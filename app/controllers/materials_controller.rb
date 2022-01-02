class MaterialsController < ApplicationController
        before_action :authorized
        before_action :admin_instructor_only, only: [:update, :destroy, :create]    
        def index
            materials = Material.order('created_at DESC')
            render json:
            {
                status: 'SUCCESS', message:"Loaded materials", data: materials
            }, status: :ok
            
        end 
        def materials_for_specific_course_of_specific_type
            materials = Material.where(course_id: params[:course_id], material_type: params[:material_type])
            data = materials
            if params[:material_type] == 'file'
                data = []
                materials.each do |material|
                data.push({
                    material: material,
                    file: polymorphic_url(material.file)
                })
                end
            end
            render json:
            {
                message:"Loaded materials", data: data
            }, status: :ok      
        end 
        def materials_for_specific_course
            
            materials = Material.where(course_id: params[:course_id])
            render json:
            {
                status: 'SUCCESS', message:"Loaded materials", data: materials
            }, status: :ok      
        end 
        def create
                course = Course.find_by(user_id: @user.id, id: video_material_params[:course_id])
                if course
                    materials = Material.create!(video_material_params)
                    render json:
                    {
                        status: 'SUCCESS', message:"created material video", data: materials
                    }, status: :ok
                else
                    render json:
                    {
                         error: "Not autherized"
                    }, status: 500
                end
            
        end 
        def create_file
                course = Course.find_by(user_id: @user.id, id: file_material_params[:course_id])
                if course
                    materials = Material.create!(file_material_params)
                    materials.file.attach(file_material_params[:file])
                    if materials.file.attached? 
                        render json:
                        {
                            status: 'SUCCESS', message:"created material pdf file", data: materials
                        }, status: 200
                    else
                        render json:
                        {
                            message:"couldn't create material pdf file", 
                        }, status: 500
                    end
                else
                    render json:
                    {
                        status: 'FAILED', message:"Not autherized"
                    }, status: 500
                end
            
        end 
        def show
            material = Material.find(params[:id])
            if material.material_type == 'video'
                render json:
                {
                    status: 'SUCCESS', message:"Loaded material", data: material
                }, status: :ok
            end
        end
        def show_file
            material = Material.find(params[:id])
            if material.material_type == 'file'
                send_data material.file.download, filename: material.file.filename.to_s, content_type: material.file.content_type, course_id: material.course_id, name: material.name, id: material.id
            end
        end
        def update
            course = Course.find_by(user_id: @user.id, id: video_material_params[:course_id])
            if course
                material = Material.find(params[:id])
                if material.update(video_material_params)
                    render json:
                    {
                        status: 'SUCCESS', message:"updated material", data: material
                    }, status: :ok 
                else
                    render json:
                    {
                        message:"Material not updated", data: material.errors
                    }, status: 500  
                end
            else
                render json:
                {
                    status: 'FAILED', message:"Not autherized"
                }, status: 500
            end

        end
        def destroy
            course = Course.find_by(user_id: @user.id, id: video_material_params[:course_id])
            if course
                material = Material.find(params[:id])
                material.destroy
                render json:
                {
                    status: 'SUCCESS', message:"Deleted material", data: material
                }, status: :ok
            else
                render json:
                {
                    status: 'FAILED', message:"Not autherized"
                }, status: 500
            end
        end
    
        private
    
        def video_material_params
            params.permit(:material_type, :content, :course_id, :name)
        end
        def file_material_params
            params.permit(:material_type, :course_id, :file, :name)
        end
        def admin_instructor_only
            unless @user.user_type == 'admin' || 'instructor'
              redirect_to :back, :alert => "Access denied."
            end
        end
        
    
    end