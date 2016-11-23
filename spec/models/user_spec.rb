require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(attributes_for(:user)) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without an email" do
    subject.email = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a city" do
    subject.city = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a password" do
    subject.password = nil
    expect(subject).to_not be_valid
  end
  it "is not valid when password different from password confirmation" do
    subject.password = "password"
    subject.password_confirmation = "123456"
    expect(subject).to_not be_valid
  end

  #Paperclip attachment
  it { should have_attached_file(:avatar) }
  it { should validate_attachment_content_type(:avatar).
              allowing('image/png', 'image/gif').
              rejecting('text/plain', 'text/xml') }

  describe "Associations" do
    it "has many posts" do
      assc = described_class.reflect_on_association(:posts)
      expect(assc.macro).to eq :has_many
    end

    it "has many friendships" do
      assc = described_class.reflect_on_association(:friendships)
      expect(assc.macro).to eq :has_many
    end

    it "has many friends" do
      assc = described_class.reflect_on_association(:friends)
      expect(assc.macro).to eq :has_many
    end
  end
end
