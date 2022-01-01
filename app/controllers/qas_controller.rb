class QasController < ApplicationController
    before_action :authorized

    def get_all_qas_for_specific_course
        qas = Qa.joins(:user).where(course_id: params[:course_id]).select('qas.id, qas.content, users.id as learner_id, users.user_name as learner_user_name, users.first_name as learner_first_name, users.last_name as learner_last_name')
        render json:
        {
            status: 'SUCCESS', message:"Loaded qas", data: qas
        }, status: :ok
    end

    def get_specific_qa
        qa = Qa.joins("INNER JOIN replies ON replies.qa_id = qas.id
            INNER JOIN users ON users.id = replies.user_id").where("qas.id": params[:id]).select('qas.course_id, qas.content, replies.id as id, replies.content as reply_content, replies.qa_id as reply_qa_id, replies.user_id as reply_user_id, users.id as reply_user_id, users.user_name as reply_user_name, users.first_name as reply_first_name, users.last_name as reply_last_name')

        if not qa.empty?
            render json:
            {
                status: 'SUCCESS', message:"Loaded qa", data: qa
            }, status: :ok
        else
            render json:
            {
                status: 'FAILED', message:"Qa not found", data: qa
            }, status: 404
        end
    end

    def create_qa_for_specific_course
        qa = Qa.new(content: params[:content], course_id: params[:course_id], user_id: @user.id)

        if qa.save
            render json:
            {
                status: 'SUCCESS', message:"created qa", data: qa
            }, status: :ok
        else
            render json:
            {
                status: 'FAILED', message:"QA not created"
            }, status: 500
        end
    end

    def create_reply_for_specific_qa
        reply = Reply.new(content: params[:content], qa_id: params[:qa_id], user_id: @user.id)
        
        if reply.save
            render json:
            {
                status: 'SUCCESS', message:"created reply", data: reply
            }, status: :ok
        else
            render json:
            {
                status: 'FAILED', message:"Reply not created"
            }, status: 500
        end
    end
end