FactoryBot.define do
  factory :activity do
    sequence(:name) { |n| "Activity #{n}" }
    description { "A test activity description." }
    association :vibe
  end
end