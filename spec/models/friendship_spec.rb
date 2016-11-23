require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let!(:user_one) { create(:user) }
  let!(:user_two) { create(:user) }

  subject { described_class.new(user: user_one, friend: user_two) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without a user" do
    subject.user = nil
    expect(subject).to_not be_valid
  end

   it "is not valid without a friend" do
    subject.friend = nil
    expect(subject).to_not be_valid
  end

  it "is not valid if user is same as friend" do
    subject.friend = user_one
    expect(subject).to_not be_valid
  end

  it "creates reverse friendship" do
    expect { create(:friendship) }.to change(Friendship, :count).by(2)
  end

  it "destroys reverse friendship" do
    friendship = create(:friendship)
    expect { friendship.destroy }.to change(Friendship, :count).by(-2)
  end

  describe "Associations" do
    it "belongs to user" do
      assc = described_class.reflect_on_association(:user)
      expect(assc.macro).to eq :belongs_to
    end

    it "belongs to friend" do
      assc = described_class.reflect_on_association(:friend)
      expect(assc.macro).to eq :belongs_to
    end
  end
end
