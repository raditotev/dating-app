FactoryGirl.define do
  factory :friendship do
    user { create(:user) }
    friend { create(:user) }
  end

end
