class QuestionsController < ApplicationController
        before_action :authorized
        before_action :admin_instructor_only, only: [:update, :destroy, :create]    
        def index
            questions = Question.order('created_at DESC')
            render json:
            {
                status: 'SUCCESS', message:"Loaded questions", data: questions
            }, status: :ok
            
        end 
        def question_for_specific_quiz            
            questions = Question.where(quiz_id: params[:quiz_id])
            render json:
            {
                status: 'SUCCESS', message:"Loaded questions", data: questions
            }, status: :ok      
        end 
    
        def create
            course = Course.find_by(user_id: @user.id).join(:quizzes).where(quizzes: {id: question_params[:quiz_id]})
            if course
                questions = Question.create!(question_params)
                render json:
                {
                    status: 'SUCCESS', message:"created question", data: questions
                }, status: :ok
            else
                render json:
                {
                    status: 'FAILED', message:"Not autherized", data: questions
                }, status: :ok
            end
            
        end 
        def show
            question = Question.find(params[:id])
            render json:
            {
                status: 'SUCCESS', message:"Loaded question", data: question
            }, status: :ok
        end
        def update
            course = Course.find_by(user_id: @user.id).join(:quizzes).where(quizzes: {id: question_params[:quiz_id]})
            if course
                question = Question.find(params[:id])
                if question.update(question_params)
                    render json:
                    {
                        status: 'SUCCESS', message:"updated question", data: question
                    }, status: :ok 
                else
                    render json:
                    {
                        status: 'FAILED', message:"Question not updated", data: question.errors
                    }, status: 500  
                end
            else
                render json:
                {
                    status: 'FAILED', message:"Not autherized", data: questions
                }, status: :ok
            end

        end
        def destroy
            course = Course.find_by(user_id: @user.id).join(:quizzes).where(quizzes: {id: question_params[:quiz_id]})
            if course
                question = Question.find(params[:id])
                question.destroy
                render json:
                {
                    status: 'SUCCESS', message:"Deleted question", data: question
                }, status: :ok
            else
                render json:
                {
                    status: 'FAILED', message:"Not autherized", data: questions
                }, status: :ok
            end
        end
    
        private
    
        def question_params
            params.permit(:quiz_id, :ques, :answer, :choices)
        end
        def admin_instructor_only
            unless @user.user_type == 'admin' || 'instructor'
              redirect_to :back, :alert => "Access denied."
            end
        end
        
    
    end