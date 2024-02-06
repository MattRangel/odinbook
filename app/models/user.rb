class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[github]

  validates :bio, length: { maximum: 100 }
  validates :name, length: { maximum: 12 }, presence: true
  has_many :followed_by_relationships, class_name: "Relationship", foreign_key: "following_id"
  has_many :following_relationships, class_name: "Relationship", foreign_key: "followed_by_id"

  delegate :following_ids, to: :following_relationships

  has_many :posts
  has_many :likes
  has_many :comments

  def feed_user_ids
    self.following_ids << self.id
  end

  def following?(user)
    self.following_relationships.where(following: user).any?
  end
end
