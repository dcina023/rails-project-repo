class Plan < ApplicationRecord
  belongs_to :user

  has_many :plan_interests
  has_many :interests, through: :plan_interests

  validates :title, presence: true
  validates :location, presence: true

  def add_random_interests(count = 3)
    Interest.order("RANDOM()").limit(count).each do |interest|
      plan_interests.create!(
        interest: interest,
        rating: rand(1..5),
        notes: "Generated activity"
      )
    end
  end
end
