class Post < ApplicationRecord
  belongs_to :user
  validates :body, length: { maximum: 250 }
end
