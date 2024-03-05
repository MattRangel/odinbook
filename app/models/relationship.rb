class Relationship < ApplicationRecord
  belongs_to :followed_by, class_name: "User"
  belongs_to :following, class_name: "User"
  validates :followed_by, uniqueness: { scope: :following, message: "relationship already exists"}

  scope :accepted, -> { where(accepted: true) }
  scope :pending, -> { where(accepted: false) }

  def accepted?
    self.accepted
  end

  def pending?
    !self.accepted
  end
end
