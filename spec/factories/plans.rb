FactoryBot.define do
  factory :plan do
    association :user
    title { "Test Plan Title" }
    location { "Minneapolis, MN" }
    budget { 40.0 }
    vibe { "Artsy" }
  end
end