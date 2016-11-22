class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/missing.png", dependent: :destroy

  has_many :posts, foreign_key: "author_id", dependent: :destroy

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
  validates_presence_of :name


end
