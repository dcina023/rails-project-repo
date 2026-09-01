class PlanInterest < ApplicationRecord
  belongs_to :plan
  belongs_to :interest

  validates :notes, presence: true
  validates :rating, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 10,
  }
end
