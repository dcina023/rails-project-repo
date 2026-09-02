# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#
#
# db/seeds.rb

require "faker"

puts "Clearing existing data..."

PlanInterest.destroy_all
Plan.destroy_all
Interest.destroy_all
User.destroy_all

puts "Creating users..."

users = Array.new(10) do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "password123",
    password_confirmation: "password123"
  )
end

puts "Creating interests..."

interests = [
  ["Food", "Discover local flavors, memorable meals, and favorite places to eat."],
  ["Music", "Find live shows, listening spots, and experiences built around sound."],
  ["Art", "Explore galleries, public art, creative workshops, and inspiring exhibitions."],
  ["Outdoors", "Enjoy fresh-air activities, scenic routes, parks, and open spaces."],
  ["Nightlife", "Check out bars, late-night venues, dancing, and evening entertainment."],
  ["History", "Visit landmarks, museums, heritage sites, and stories from the past."],
  ["Shopping", "Browse boutiques, markets, specialty shops, and unique local finds."],
  ["Wellness", "Recharge with fitness, mindfulness, spas, movement, and healthy routines."],
  ["Dogs", "Find dog-friendly places, parks, patios, and activities for pups."],
  ["Cats", "Enjoy cat-friendly spaces, cafes, shelters, and feline-focused experiences."],
  ["Nature", "Connect with trails, gardens, wildlife, and peaceful natural settings."],
  ["Sports", "Catch games, join activities, and explore local athletic experiences."],
  ["Coffee", "Find cozy cafes, espresso bars, roasters, and favorite coffee stops."],
].map do |name, description|
  Interest.create!(
    name: name,
    description: description
  )
end

puts "Creating plans..."

plan_titles = [
  "Weekend Food Crawl",
  "Sunset Hike",
  "Museum Date",
  "Coffee Shop Tour",
  "Live Music Night",
  "Farmers Market Morning",
  "Historic Downtown Walk",
  "Beach Picnic",
  "Boutique Shopping Day",
  "Spa And Wellness Escape",
]

plans = Array.new(10) do
  Plan.create!(
    user: users.sample,
    title: plan_titles.sample,
    location: "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
    budget: Faker::Number.decimal(l_digits: 3, r_digits: 2),
    vibe: %w[
      relaxed
      adventurous
      romantic
      family-friendly
      luxury
      budget-conscious
      spontaneous
      cultural
    ].sample
  )
end

puts "Creating plan interests..."

plan_interest_notes = [
  "A strong fit for the plan and easy to include in the itinerary.",
  "Adds variety without taking the day too far off schedule.",
  "Good option for filling time between the main planned stops.",
  "Works best as a relaxed activity with room to explore nearby spots.",
  "Helps shape the overall vibe and gives the plan more personality.",
  "Worth prioritizing if there is extra time in the afternoon.",
  "Pairs well with nearby food, coffee, or shopping stops.",
  "A simple way to make the plan feel more local and memorable.",
  "Best for a low-pressure stop that does not require much planning.",
  "Adds a fun shared experience without stretching the budget too much.",
]

plans.each do |plan|
  interests.sample(rand(2..5)).each do |interest|
    PlanInterest.create!(
      plan: plan,
      interest: interest,
      rating: rand(1..5),
      notes: plan_interest_notes.sample
    )
  end
end

puts "Seed complete!"
puts "#{User.count} users created"
puts "#{Interest.count} interests created"
puts "#{Plan.count} plans created"
puts "#{PlanInterest.count} plan interests created"
puts "Seeded user password: password123"
