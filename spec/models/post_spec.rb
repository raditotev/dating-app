require 'rails_helper'

RSpec.describe Post, type: :model do
  subject { described_class.new(attributes_for(:post)) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without an body" do
    subject.body = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a author" do
    subject.author = nil
    expect(subject).to_not be_valid
  end


  describe "Associations" do
    it "belongs to author" do
      assc = described_class.reflect_on_association(:author)
      expect(assc.macro).to eq :belongs_to
    end
  end

  describe "Default scope" do
    let!(:post_one) { create(:post) }
    let!(:post_two) { create(:post) }

    it 'orders by ascending' do
      expect(Post.all).to eq [post_two, post_one]
    end
  end
end
