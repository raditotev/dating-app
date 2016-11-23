class Friendship < ApplicationRecord
  validates_uniqueness_of :friend_id , scope: :user_id

  validate :check_self_referential_friendship

  belongs_to :user
  belongs_to :friend, class_name: "User"

  after_create :ensure_reverse_friendship
  after_destroy :destroy_reverse_friendship

  private

  def check_self_referential_friendship
    if user_id == friend_id
      errors.add(:friend_id, "User and friend can't be the same object")
    end
  end

  def ensure_reverse_friendship
    unless Friendship.exists?(user: self.friend, friend: self.user)
      Friendship.create(user: self.friend, friend: self.user)
    end
  end

  def destroy_reverse_friendship
    if Friendship.exists?(user: self.friend, friend: self.user)
      Friendship.find_by(user: self.friend, friend: self.user).destroy
    end
  end
end
