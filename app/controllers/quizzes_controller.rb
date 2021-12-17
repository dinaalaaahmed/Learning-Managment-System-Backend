class QuizzesController < ApplicationController    
        before_action :authorized
        before_action :admin_instructor_only, only: [:update, :destroy, :create]    
        def index
            quizzes = Quiz.order('created_at DESC')
            render json:
            {
                status: 'SUCCESS', message:"Loaded quizzes", data: quizzes
            }, status: :ok
            
        end 
        def quizzes_for_specific_course            
            quizzes = Quiz.where(course_id: params[:course_id])
            render json:
            {
                status: 'SUCCESS', message:"Loaded quizzes", data: quizzes
            }, status: :ok      
        end 
    
        def create
            course = Course.find_by(user_id: @user.id, id: quiz_params[:course_id])
            if course
                quizzes = Quiz.create!(quiz_params)
                render json:
                {
                    status: 'SUCCESS', message:"created quiz", data: quizzes
                }, status: :ok
            else
                render json:
                {
                    status: 'FAILED', message:"Not autherized", data: quizzes
                }, status: :ok
            end
            
        end 
        def show
            quiz = Quiz.find(params[:id])
            render json:
            {
                status: 'SUCCESS', message:"Loaded quiz", data: quiz
            }, status: :ok
        end
        def update
            course = Course.find_by(user_id: @user.id, id: quiz_params[:course_id])
            if course
                quiz = Quiz.find(params[:id])
                if quiz.update(quiz_params)
                    render json:
                    {
                        status: 'SUCCESS', message:"updated quiz", data: quiz
                    }, status: :ok 
                else
                    render json:
                    {
                        status: 'FAILED', message:"Quiz not updated", data: quiz.errors
                    }, status: 500  
                end
            else
                render json:
                {
                    status: 'FAILED', message:"Not autherized", data: quizzes
                }, status: :ok
            end

        end
        def destroy
            course = Course.find_by(user_id: @user.id, id: quiz_params[:course_id])
            if course
                quiz = Quiz.find(params[:id])
                quiz.destroy
                render json:
                {
                    status: 'SUCCESS', message:"Deleted quiz", data: quiz
                }, status: :ok
            else
                render json:
                {
                    status: 'FAILED', message:"Not autherized", data: quizzes
                }, status: :ok
            end
        end
    
        private
    
        def quiz_params
            params.permit(:title, :course_id)
        end
        def admin_instructor_only
            unless @user.user_type == 'admin' || 'instructor'
              redirect_to :back, :alert => "Access denied."
            end
        end
        
    
    end