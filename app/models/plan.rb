class Plan < ApplicationRecord
  belongs_to :user

  has_many :plan_activities, dependent: :destroy
  has_many :activities, through: :plan_activities

  validates :title, presence: true
  validates :location, presence: true

  VIBES = %w[Artsy Foodie Outdoorsy Cozy Nightlife].freeze

  validates :vibe, inclusion: { in: VIBES }

  def assign_random_activities(count = 3)
    Activity.random_for_vibe(self, count).each do |activity|
      plan_activities.create!(
        activity: activity,
        notes: "Auto-selected for this plan.",
        rating: rand(1..5)
      )
    end
  end
end
