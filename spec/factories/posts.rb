FactoryGirl.define do
  factory :post do
    title "Post Titile"
    body "Post Text"
    author { create(:user) }
  end

end
