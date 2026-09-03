FactoryBot.define do
  factory :activity do
    sequence(:name) { |n| "Activity #{n}" }
    description { "A test activity description." }
    vibe { "Outdoorsy" }
  end
end