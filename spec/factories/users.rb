FactoryGirl.define do
  factory :user do
    name "John Doe"
    city "London"
    avatar { File.new(Rails.public_path + "images/beast.png") }
    email "john_doe@mail.com"
    password "password"
    password_confirmation "password"
  end

end
