class Plan < ApplicationRecord
  belongs_to :user

  has_many :plan_activities
  has_many :activities, through: :plan_activities

  validates :title, presence: true
  validates :location, presence: true

  def add_random_activities(count = 3)
    Activity.order("RANDOM()").limit(count).each do |activity|
      plan_activities.create!(
        activity: activity,
        rating: rand(1..5),
        notes: "Generated activity"
      )
    end
  end
end
