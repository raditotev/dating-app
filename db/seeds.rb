# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.destroy_all
Post.destroy_all

user = User.create(name: "Example User", city: "London", avatar: File.open(Rails.public_path + "images/beast.png"), email: "example@mail.com", password: "password", password_confirmation: "password")

10.times do
    User.create(name: Faker::Name.name, city: Faker::Address.city, avatar: File.open(Rails.public_path + "images/beast.png"), email: Faker::Internet.email, password: "password", password_confirmation: "password")
end

User.all.each do |u|
  10.times { u.posts.create(title: Faker::Book.title, body: Faker::Hipster.paragraph) }
end


User.all[1...-1].each {|friend| user.friendships.create(friend: friend) }
