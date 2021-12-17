class Course < ApplicationRecord
    belongs_to :user
    validates_presence_of :name, :syllabus
    has_many :quizzes, dependent: :destroy
    has_many :materials, dependent: :destroy

end
