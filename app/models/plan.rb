class Plan < ApplicationRecord
  VIBES = %w[Artsy Foodie Outdoorsy Cozy Nightlife].freeze

  belongs_to :user

  has_many :plan_activities, dependent: :destroy
  has_many :activities, through: :plan_activities

  validates :title, presence: true
  validates :location, presence: true
  validates :budget, numericality: {
    greater_than_or_equal_to: 20,
    less_than_or_equal_to: 300,
  }
  validates :vibe, inclusion: { in: VIBES }

  after_commit :assign_random_activities

  def assign_random_activities(count = 3)
    Activity.random_for_vibe(vibe, count).each do |activity|
      plan_activities.create!(
        activity: activity,
        notes: "Auto-selected for this plan.",
        rating: rand(1..5)
      )
    end
  end
end
