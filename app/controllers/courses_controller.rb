class CoursesController < ApplicationController
    before_action :authorized
    before_action :admin_instructor_only, only: [:update, :destroy, :create]

    def index
        courses = Course.joins(:user).select('courses.id,courses.name, users.id as instructor_id, users.user_name as instructor_user_name, users.first_name as instructor_first_name, users.last_name as instructor_last_name')
        render json:
        {
            status: 'SUCCESS', message:"Loaded courses", data: courses
        }, status: :ok
        
    end 
    def courses_for_specific_instructor
        courses = Course.where(user_id: params[:instructor_id])
        render json:
        {
            status: 'SUCCESS', message:"Loaded courses", data: courses
        }, status: :ok      
    end 
    def create
        courses = Course.create!(syllabus: course_params[:syllabus], name: course_params[:name], user_id: @user.id)
        render json:
        {
            status: 'SUCCESS', message:"created course", data: courses
        }, status: :ok
        
    end 
    def show
        course = Course.joins(:user).where(id: params[:id]).select('courses.id, courses.name, courses.syllabus, users.email as instructor_email,users.id as instructor_id, users.user_name as instructor_user_name, users.first_name as instructor_first_name, users.last_name as instructor_last_name')
        render json:
        {
            status: 'SUCCESS', message:"Loaded course", data: course
        }, status: :ok
    end
    def update
        course = Course.find(params[:id])
        if course.update(course_params)
            render json:
            {
                status: 'SUCCESS', message:"updated course", data: course
            }, status: :ok 
        else
            render json:
            {
                status: 'FAILED', message:"Course not updated", data: course.errors
            }, status: 500  
        end
    end
    def destroy
        course = Course.find(params[:id])
        course.destroy
        render json:
        {
            status: 'SUCCESS', message:"Deleted course", data: course
        }, status: :ok
    end

    private

    def course_params
        params.permit(:name, :syllabus)
    end
    def admin_instructor_only
        unless @user.user_type == 'admin' || 'instructor'
          redirect_to :back, :alert => "Access denied."
        end
    end
    

end