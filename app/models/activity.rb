class Activity < ApplicationRecord
  belongs_to :vibe

  has_many :plan_activities, dependent: :destroy
  has_many :plans, through: :plan_activities

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  scope :randomized, -> { order(Arel.sql("RANDOM()")) }

  def self.random_for_vibe(vibe, count = 3)
    for_vibe(vibe).randomized.limit(count)
  end
end
