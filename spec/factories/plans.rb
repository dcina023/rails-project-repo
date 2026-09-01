FactoryBot.define do
  factory :plan do
    title { "Test Plan Title" }
    location { "Minneapolis, MN" }
    vibe { "Artsty" }
    budget { 40.0 }
    user_id { 2 }
  end
end