class User < ApplicationRecord
  has_many :plans
  has_many :interests, through: :plans

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  
end