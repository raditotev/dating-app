require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do

  before(:each) do
    @user = create(:user)
  end

  it "returns url to user's avatar" do
    expect(avatar(@user)).to eq(image_tag (@user.avatar.url(:thumb)))
  end
end
