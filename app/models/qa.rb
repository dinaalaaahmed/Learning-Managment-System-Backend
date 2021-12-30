class QA < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :replies, dependent: :destroy
end