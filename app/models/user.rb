class User < ApplicationRecord

    has_secure_password
    has_many :courses, dependent: :destroy
    validates_presence_of :email, :password_digest, :user_name, :first_name, :last_name, :birth_date
    validates_uniqueness_of :user_name, :email
    has_many :takequizess
    has_many :quizzes, through: :takequizess
end
