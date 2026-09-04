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

PlanActivity.destroy_all
Activity.destroy_all
Plan.destroy_all
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

puts "Creating activities..."

activities_data = [
  ["Visit a local art museum", "Explore exhibits, installations, and visual art collections.", "Artsy"],
  ["Take a pottery class", "Try a hands-on creative workshop with clay.", "Artsy"],
  ["Explore a gallery district", "Walk through local galleries and artist-run spaces.", "Artsy"],
  ["Find a public mural walk", "Discover colorful murals and street art around the city.", "Artsy"],

  ["Try a brunch spot", "Enjoy a relaxed meal at a popular local brunch restaurant.", "Foodie"],
  ["Visit a farmers market", "Browse fresh produce, baked goods, and local food vendors.", "Foodie"],
  ["Go on a dessert crawl", "Sample sweets from bakeries, cafes, and dessert shops.", "Foodie"],
  ["Book a tasting menu", "Enjoy a curated dining experience with multiple courses.", "Foodie"],

  ["Walk a scenic trail", "Spend time outside on a relaxed nature walk or hike.", "Outdoorsy"],
  ["Have a picnic in the park", "Pack snacks and enjoy an easy outdoor meal.", "Outdoorsy"],
  ["Visit a botanical garden", "Explore plants, flowers, and peaceful garden paths.", "Outdoorsy"],
  ["Rent bikes", "Ride through trails, parks, or bike-friendly neighborhoods.", "Outdoorsy"],

  ["Visit a cozy bookstore", "Browse books and enjoy a calm, quiet atmosphere.", "Cozy"],
  ["Settle into a coffee shop", "Relax with coffee, pastries, and conversation.", "Cozy"],
  ["Watch an indie movie", "Catch a film at a small theater or cinema.", "Cozy"],
  ["Try a tea house", "Enjoy tea, light snacks, and a slower-paced stop.", "Cozy"],

  ["See live music", "Catch a band, open mic, or intimate local performance.", "Nightlife"],
  ["Try a cocktail bar", "Visit a stylish bar with creative drinks.", "Nightlife"],
  ["Go dancing", "Find a lively spot for music and dancing.", "Nightlife"],
  ["See a comedy show", "Spend the evening at a stand-up or improv performance.", "Nightlife"],
]

activities = activities_data.map do |name, description, vibe|
  Activity.create!(
    name: name,
    description: description,
    vibe: vibe
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
  "Park Picnic",
  "Gallery Afternoon",
  "Cozy Saturday Escape",
]

plans = Array.new(10) do
  Plan.create!(
    user: users.sample,
    title: plan_titles.sample,
    location: "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
    budget: Faker::Commerce.price(range: 20..300.0),
    vibe: Plan::VIBES.sample
  )
end

puts "Creating plan activities..."

plan_activity_notes = [
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
  matching_activities = activities.select { |activity| activity.vibe == plan.vibe }

  matching_activities.sample(3).each do |activity|
    PlanActivity.create!(
      plan: plan,
      activity: activity,
      notes: plan_activity_notes.sample,
      rating: rand(1..5)
    )
  end
end

puts "Seed complete!"
puts "#{User.count} users created"
puts "#{Activity.count} activities created"
puts "#{Plan.count} plans created"
puts "#{PlanActivity.count} plan activities created"
puts "Seeded user password: password123"
