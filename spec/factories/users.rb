FactoryGirl.define do
  factory :user do
    name:"John Doe"
    email:"john_doe@mail.com"
    password:"password"
    password_confirmation:"password"
  end

end
