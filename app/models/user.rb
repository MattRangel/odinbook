class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :followed_by_relationships, class_name: "Relationship", foreign_key: "following_id"
  has_many :following_relationships, class_name: "Relationship", foreign_key: "followed_by_id"

  has_many :posts
  has_many :likes
  has_many :comments

  def follow(user)
    self.following_relationships.create( following: user )
  end

  def like(post)
    self.likes.create(post: post)
  end
end
