class Quiz < ApplicationRecord
    belongs_to :course
    has_many :takequizess, dependent: :destroy
    has_many :users, through: :takequizess
    has_many :questions, dependent: :destroy

end
