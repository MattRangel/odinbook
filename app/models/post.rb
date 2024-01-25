class Post < ApplicationRecord
  belongs_to :user
  validates :body, length: { maximum: 250 }

  has_many :likes
  has_many :comments
end
