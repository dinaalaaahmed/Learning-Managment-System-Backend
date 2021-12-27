class UsersController < ApplicationController
            before_action :authorized
            def index
                users = User.order('created_at DESC')
                render json:
                {
                    status: 'SUCCESS', message:"Loaded users", data: users
                }, status: :ok
                
            end 
            def show
                user = User.find(@user.id)
                render json:
                {
                    status: 'SUCCESS', message:"Loaded user", data: user
                }, status: :ok
            end
            def change_role
                if @user.user_type == 'admin'
                    user = User.find(change_role_params[:user_id])
                    if user.update(user_type: change_role_params[:user_type])
                        render json:
                        {
                            status: 'SUCCESS', message:"updated user", data: user
                        }, status: :ok 
                    else
                        render json:
                        {
                            status: 'FAILED', message:"User not updated", data: user.errors
                        }, status: 500  
                    end
                else
                    render json:
                    {
                        status: 'Unautherized', message:"Require Administrator only"
                    }, status: 401  
                end
            end
            def update
                user = User.find(@user.id)
                if user.update(user_params)
                    render json:
                    {
                        status: 'SUCCESS', message:"updated user", data: user
                    }, status: :ok 
                else
                    render json:
                    {
                        status: 'FAILED', message:"User not updated", data: user.errors
                    }, status: 500  
                end
            end
            def destroy
                user = User.find(@user.id)
                user.destroy
                render json:
                {
                    status: 'SUCCESS', message:"Deleted user", data: user
                }, status: :ok
            end

            private
            def user_params
                params.permit(:email, :password, :user_name, :user_type, :first_name, :last_name, :birth_date)
            end
            def change_role_params
                params.permit(:user_id, :user_type)
            end
            def admin_only
                unless current_user.user_type == 'admin'
                  redirect_to :back, :alert => "Access denied."
                end
            end
            

end