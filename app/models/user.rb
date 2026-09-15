class User < ApplicationRecord
  has_many :plans, dependent: :destroy
  has_many :plan_activities, through: :plans
  has_many :activities, through: :plan_activities

  normalizes :email, with: ->(email) { email.strip.downcase }
  validates :name, presence: true

  has_secure_password
end
