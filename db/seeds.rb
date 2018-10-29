# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.where(email: ENV['TEST_USER_EMAIL'])
unless user.exists?
  puts "Creating test User"
  User.create!(email: ENV['TEST_USER_EMAIL'], password: ENV['TEST_USER_PASSWORD'], confirmed_at: Time.now)
else
  puts "dummy user exists"
end
