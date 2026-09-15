class Plan < ApplicationRecord
  belongs_to :user
  belongs_to :vibe

  has_many :plan_activities, dependent: :destroy
  has_many :activities, through: :plan_activities

  validates :title, presence: true
  validates :location, presence: true
  validates :budget, numericality: {
    greater_than_or_equal_to: 20,
    less_than_or_equal_to: 300,
  }

  after_create_commit :assign_random_activities

  def assign_random_activities(count = 3)
    vibe.random_activities(count).each do |activity|
      plan_activities.create!(
        activity: activity,
        notes: "Auto-selected for this plan.",
        rating: rand(1..5)
      )
    end
  end
end
