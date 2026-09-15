FactoryBot.define do
  factory :vibe do
    sequence(:title) { |n| "Vibe #{n}" }
    caption { "MyText" }
  end
end
