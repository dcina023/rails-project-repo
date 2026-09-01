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

interests = %w[
  Food
  Music
  Art
  Outdoors
  Nightlife
  History
  Shopping
  Wellness
  Sports
  Coffee
].map do |name|
  Interest.create!(
    name: name,
    description: Faker::Lorem.sentence(word_count: 8)
  )
end

puts "Creating plans..."

plans = Array.new(10) do
  Plan.create!(
    user: users.sample,
    title: Faker::Lorem.sentence(word_count: 3).delete_suffix("."),
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

plans.each do |plan|
  interests.sample(rand(2..5)).each do |interest|
    PlanInterest.create!(
      plan: plan,
      interest: interest,
      rating: rand(1..5),
      notes: Faker::Lorem.sentence(word_count: 10)
    )
  end
end

puts "Seed complete!"
puts "#{User.count} users created"
puts "#{Interest.count} interests created"
puts "#{Plan.count} plans created"
puts "#{PlanInterest.count} plan interests created"
puts "Seeded user password: password123"
