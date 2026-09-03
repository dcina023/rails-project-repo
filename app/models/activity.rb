class Activity < ApplicationRecord
  has_many :plan_activities, dependent: :destroy
  has_many :plans, through: :plan_activities

  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  validates :vibe, inclusion: { in: Plan::VIBES }

  scope :for_vibe, ->(vibe) { where(vibe: vibe) }
  scope :randomized, -> { order(Arel.sql("RANDOM()")) }

  def self.random_for_vibe(vibe, count = 3)
    for_vibe(vibe).randomized.limit(count)
  end
end
