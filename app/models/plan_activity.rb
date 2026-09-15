class PlanActivity < ApplicationRecord
  belongs_to :plan
  belongs_to :activity

  validates :rating, numericality: true, allow_nil: true
  validates :activity_id, uniqueness: { scope: :plan_id }
end
