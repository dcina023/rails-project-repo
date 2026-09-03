FactoryBot.define do
  factory :plan_activity do
    association :plan
    association :activity
    rating { 4 }
    notes { "Test note" }
  end
end