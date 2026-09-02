class Activity < ApplicationRecord
  has_many :plan_activities
  has_many :plans, through: :plan_activities

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
end
