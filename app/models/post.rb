class Post < ApplicationRecord
  belongs_to :author, class_name: "User"

  validates_presence_of :title, :body

  default_scope -> { order(created_at: :desc) }
end
