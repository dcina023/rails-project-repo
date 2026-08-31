class Plan < ApplicationRecord
  belongs_to :user

  has_many :plan_interests
  has_many :interests, through: :plan_interests

  validates :title, presence: true
  validates :location, presence: true
end
