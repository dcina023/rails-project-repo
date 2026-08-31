class User < ApplicationRecord
  has_many :plans
  has_many :interests, through: :plans

  has_secure_password

  validates :name, presence: true
  normalizes :email, with: ->(email) { email.strip.downcase }
end
