class Post < ApplicationRecord
  belongs_to :user
  validates :body, length: { maximum: 250 }

  default_scope { order(created_at: :desc) }
  scope :for_view, -> { includes(:user, :likes, comments: [:user]) }

  has_many :likes
  has_many :comments

  def self.feed(id_list)
    for_view.where(user_id: id_list)
  end
end
