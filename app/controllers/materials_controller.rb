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
            render json:
            {
                status: 'SUCCESS', message:"Loaded materials", data: materials
            }, status: :ok      
        end 
    
        def create
            if material_params[:material_type] == "video"
                course = Course.find_by(user_id: @user.id, id: material_params[:course_id])
                if course
                    materials = Material.create!(material_type: material_params[:material_type], content: material_params[:content], course_id: material_params[:course_id], name: material_params[:name])
                    render json:
                    {
                        status: 'SUCCESS', message:"created material video", data: materials
                    }, status: :ok
                else
                    render json:
                    {
                        status: 'FAILED', message:"Not autherized", data: materials
                    }, status: :ok
                end
            end
        end 
        def create_file
            if material_params[:material_type] == "file"
                course = Course.find_by(user_id: @user.id, id: material_params[:course_id])
                if course
                    materials = Material.create!(material_type: material_params[:material_type], content: material_params[:content], course_id: material_params[:course_id], name: material_params[:name])
                    render json:
                    {
                        status: 'SUCCESS', message:"created material", data: materials
                    }, status: :ok
                else
                    render json:
                    {
                        status: 'FAILED', message:"Not autherized", data: materials
                    }, status: :ok
                end
            end
        end 
        def show
            material = Material.find(params[:id])
            render json:
            {
                status: 'SUCCESS', message:"Loaded material", data: material
            }, status: :ok
        end
        def update
            course = Course.find_by(user_id: @user.id, id: material_params[:course_id])
            if course
                material = Material.find(params[:id])
                if material.update(material_params)
                    render json:
                    {
                        status: 'SUCCESS', message:"updated material", data: material
                    }, status: :ok 
                else
                    render json:
                    {
                        status: 'FAILED', message:"Material not updated", data: material.errors
                    }, status: 500  
                end
            else
                render json:
                {
                    status: 'FAILED', message:"Not autherized", data: materials
                }, status: :ok
            end

        end
        def destroy
            course = Course.find_by(user_id: @user.id, id: material_params[:course_id])
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
                    status: 'FAILED', message:"Not autherized", data: materials
                }, status: :ok
            end
        end
    
        private
    
        def material_params
            params.permit(:material_type, :content, :course_id, :file, :name)
        end
        def admin_instructor_only
            unless @user.user_type == 'admin' || 'instructor'
              redirect_to :back, :alert => "Access denied."
            end
        end
        
    
    end