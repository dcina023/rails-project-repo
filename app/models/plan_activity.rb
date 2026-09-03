class PlanActivity < ApplicationRecord
  belongs_to :plan
  belongs_to :activity

  validates :rating, numericality: true, allow_nil: true
end
