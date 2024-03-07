class Post < ApplicationRecord
  belongs_to :user
  validates :body, length: { maximum: 250 }

  default_scope { order(created_at: :desc) }
  scope :for_view, -> { includes(:likes, user: [avatar_image_attachment: :blob], comments: [user: [avatar_image_attachment: :blob]]) }

  has_many :likes
  has_many :comments

  def self.feed(id_list)
    for_view.where(user_id: id_list)
  end

  def liked_by_id?(user_id)
    !likes.detect { |like| like.user_id.eql?(user_id) }.nil?
  end
end
