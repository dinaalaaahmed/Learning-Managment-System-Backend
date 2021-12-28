class AuthenticationController < ApplicationController
            def create
                user = User.create!(user_params)
                if user.valid?
                  token = encode_token({user_id: user.id, user_type: user.user_type})
                  render json: {user: user, token: token}
                else
                  render json: {error: "Invalid username or password" , status: 500 } 
                end
              end
            
              # LOGGING IN
              def login
                user = User.find_by(email: params[:email])
                if user && user.authenticate(user_params[:password])
                  token = encode_token({user_id: user.id, user_type: user.user_type})
                  render json: {user: user, token: token}
                else
                  render json: {error: "Invalid username or password", status: 500}  
                end
              end 
            private

            def user_params
                params.permit(:email, :password, :user_name, :user_type, :first_name, :last_name, :birth_date)
            end
end

