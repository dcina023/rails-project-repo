class Vibe < ApplicationRecord
  # VIBES = %w[Artsy Foodie Outdoorsy Cozy Nightlife Adventurous Travel].freeze
  has_many :plans, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :plan_activities, through: :activities

  validates :title, presence: true, uniqueness: true

  def random_activities(count = 3)
    activities.randomized.limit(count)
  end
end
