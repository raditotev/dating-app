FactoryGirl.define do
  factory :post do
    title "Post Titile"
    body "Post Text"
    author { create(:user) }
  end

  factory :post_without_author, class: Post do
    title "Post Titile"
    body "Post Text"
  end
end
