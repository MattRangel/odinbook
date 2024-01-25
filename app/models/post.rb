class Post < ApplicationRecord
  belongs_to :user
  validates :body, length: { maximum: 250 }

  has_many :likes
  has_many :comments

  def self.feed(id_list)
    where(user_id: id_list).order(created_at: :desc)
  end
end
