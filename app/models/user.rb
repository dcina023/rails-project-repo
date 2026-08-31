class User < ApplicationRecord
  has_many :plans
  has_many :interests, through: :plans

  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
