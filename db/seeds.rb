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
require "faker"

puts "Clearing existing data..."

PlanInterest.destroy_all
Plan.destroy_all
Interest.destroy_all
User.destroy_all

puts "Creating users..."

users = 10.times.map do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "password123",
    password_confirmation: "password123"
  )
end

puts "Creating interests..."

interest_data = [
  ["Food", "Restaurants, cafes, bakeries, and unique dining experiences"],
  ["Music", "Live music, concerts, open mics, and local performances"],
  ["Art", "Museums, galleries, exhibits, and creative workshops"],
  ["Outdoors", "Parks, walking trails, gardens, and outdoor activities"],
  ["Shopping", "Boutiques, markets, thrift stores, and local shops"],
  ["Nightlife", "Bars, lounges, dancing, and late-night events"],
  ["Wellness", "Yoga, spas, fitness, and relaxing experiences"],
  ["Culture", "Historical sites, cultural events, and neighborhood exploring"],
  ["Games", "Arcades, board game cafes, trivia, and interactive activities"],
  ["Movies", "Theaters, screenings, film events, and cozy movie nights"]
]

interests = interest_data.map do |name, description|
  Interest.create!(
    name: name,
    description: description
  )
end

puts "Creating plans..."

vibes = [
  "Chill",
  "Romantic",
  "Adventurous",
  "Creative",
  "Cozy",
  "Social",
  "Budget-friendly",
  "Upscale",
  "Relaxed",
  "Spontaneous"
]

locations = [
  "New York, NY",
  "Brooklyn, NY",
  "Queens, NY",
  "Jersey City, NJ",
  "Hoboken, NJ",
  "Philadelphia, PA",
  "Boston, MA",
  "Washington, DC"
]

30.times do
  plan = Plan.create!(
    title: "#{Faker::Adjective.positive.capitalize} #{Faker::Restaurant.type.capitalize} Meetup",
    location: locations.sample,
    budget: rand(20.0..150.0).round(2),
    vibe: vibes.sample,
    user: users.sample
  )

  interests.sample(rand(2..4)).each do |interest|
    PlanInterest.create!(
      plan: plan,
      interest: interest
    )
  end
end

puts "Seed data created successfully!"
puts "#{User.count} users created"
puts "#{Interest.count} interests created"
puts "#{Plan.count} plans created"
puts "#{PlanInterest.count} plan interests created"
puts "Seeded user password: password123"