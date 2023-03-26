# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Spree::Core::Engine.load_seed
Spree::Auth::Engine.load_seed


require 'faker'

25.times do
  user = Spree::User.new(
    name: Faker::Name.unique.name,
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password"
  )
  user.save!
end

puts "25 users have been created."