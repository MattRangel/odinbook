class Relationship < ApplicationRecord
  belongs_to :followed_by, class_name: "User"
  belongs_to :following, class_name: "User"
  validates :followed_by, uniqueness: { scope: :following, message: "relationship already exists"}

  scope :accepted, -> { where(accepted: true) }
  scope :pending, -> { where(accepted: false) }

  def self.following_ids
    pluck(:following_id)
  end

  def self.find_relationship_following(user_id)
    where(following_id: user_id).first
  end

  def self.find_relationship_followed_by(user_id)
    where(followed_by_id: user_id).first
  end

  def accepted?
    self.accepted
  end

  def pending?
    !self.accepted
  end
end
