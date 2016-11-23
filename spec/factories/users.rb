FactoryGirl.define do
  factory :user do |u|
    u.name "John Doe"
    u.city "London"
    u.avatar { File.new(Rails.public_path + "images/beast.png") }
    u.sequence(:email) { |n| "john_doe#{n}@mail.com"}
    u.password "password"
    u.password_confirmation "password"
  end

end
