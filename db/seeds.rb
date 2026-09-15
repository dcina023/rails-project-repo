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
Plan.destroy_all
Activity.destroy_all
Vibe.destroy_all
User.destroy_all

Faker::Internet.unique.clear

puts "Creating users..."

users = Array.new(10) do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "password123",
    password_confirmation: "password123"
  )
end

puts "Creating vibes and activities..."

vibes_data = [
  {
    title: "Artsy",
    caption: "Creative experiences centered around art, design, and culture.",
    activities: [
      ["Visit a local art museum", "Explore exhibits, installations, and visual art collections."],
      ["Take a pottery class", "Try a hands-on creative workshop with clay."],
      ["Explore a gallery district", "Walk through local galleries and artist-run spaces."],
      ["Find a public mural walk", "Discover colorful murals and street art around the city."]
    ]
  },
  {
    title: "Foodie",
    caption: "Local food experiences, memorable meals, and delicious discoveries.",
    activities: [
      ["Try a brunch spot", "Enjoy a relaxed meal at a popular local brunch restaurant."],
      ["Visit a farmers market", "Browse fresh produce, baked goods, and local food vendors."],
      ["Go on a dessert crawl", "Sample sweets from bakeries, cafes, and dessert shops."],
      ["Book a tasting menu", "Enjoy a curated dining experience with multiple courses."]
    ]
  },
  {
    title: "Outdoorsy",
    caption: "Fresh-air activities, scenic surroundings, and time spent in nature.",
    activities: [
      ["Walk a scenic trail", "Spend time outside on a relaxed nature walk or hike."],
      ["Have a picnic in the park", "Pack snacks and enjoy an easy outdoor meal."],
      ["Visit a botanical garden", "Explore plants, flowers, and peaceful garden paths."],
      ["Rent bikes", "Ride through trails, parks, or bike-friendly neighborhoods."]
    ]
  },
  {
    title: "Cozy",
    caption: "Relaxed, comfortable activities with an easygoing pace.",
    activities: [
      ["Visit a cozy bookstore", "Browse books and enjoy a calm, quiet atmosphere."],
      ["Settle into a coffee shop", "Relax with coffee, pastries, and conversation."],
      ["Watch an indie movie", "Catch a film at a small theater or cinema."],
      ["Try a tea house", "Enjoy tea, light snacks, and a slower-paced stop."]
    ]
  },
  {
    title: "Nightlife",
    caption: "Evening experiences with entertainment, music, and energy.",
    activities: [
      ["See live music", "Catch a band, open mic, or intimate local performance."],
      ["Try a cocktail bar", "Visit a stylish bar with creative drinks."],
      ["Go dancing", "Find a lively spot for music and dancing."],
      ["See a comedy show", "Spend the evening at a stand-up or improv performance."]
    ]
  }
]

vibes_by_title = vibes_data.each_with_object({}) do |vibe_data, vibes|
  vibe = Vibe.create!(
    title: vibe_data[:title],
    caption: vibe_data[:caption]
  )

  vibe_data[:activities].each do |activity_name, activity_description|
    vibe.activities.create!(
      name: activity_name,
      description: activity_description
    )
  end

  vibes[vibe.title] = vibe
end

puts "Creating plans..."

plans_data = [
  { title: "Weekend Food Crawl", vibe_title: "Foodie" },
  { title: "Sunset Hike", vibe_title: "Outdoorsy" },
  { title: "Museum Date", vibe_title: "Artsy" },
  { title: "Coffee Shop Tour", vibe_title: "Cozy" },
  { title: "Live Music Night", vibe_title: "Nightlife" },
  { title: "Farmers Market Morning", vibe_title: "Foodie" },
  { title: "Historic Downtown Walk", vibe_title: "Outdoorsy" },
  { title: "Park Picnic", vibe_title: "Outdoorsy" },
  { title: "Gallery Afternoon", vibe_title: "Artsy" },
  { title: "Cozy Saturday Escape", vibe_title: "Cozy" }
]

plans = plans_data.map do |plan_data|
  Plan.create!(
    user: users.sample,
    vibe: vibes_by_title.fetch(plan_data[:vibe_title]),
    title: plan_data[:title],
    location: "#{Faker::Address.city}, #{Faker::Address.state_abbr}",
    budget: Faker::Commerce.price(range: 20..300.0)
  )
end

puts "Seed complete!"
puts "#{User.count} users created"
puts "#{Vibe.count} vibes created"
puts "#{Activity.count} activities created"
puts "#{Plan.count} plans created"
puts "#{PlanActivity.count} plan activities created"
puts "Seeded user password: password123"