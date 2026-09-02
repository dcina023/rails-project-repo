class User < ApplicationRecord
  has_many :plans
  has_many :plan_activities, through: :activities
  has_many :activities, through: :plan_activities

  normalizes :email, with: ->(email) { email.strip.downcase }
  validates :name, presence: true

  has_secure_password
end

# Remember - Normalize automatically cleans up the text and validates double checks that it's safe to save.
# && has_secure_password - Is rails model method that uses the BCrypt gem to hash and authenticate passwords
