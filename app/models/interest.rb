class Interest < ApplicationRecord
  has_many :plan_interests
  has_many :plans, through: :plan_interests

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true
  
end