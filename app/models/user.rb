class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[github]

  validates :bio, length: { maximum: 100 }
  validates :name, length: { maximum: 12 }, presence: true
  has_many :followed_by_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :following_relationships, class_name: "Relationship", foreign_key: "followed_by_id", dependent: :destroy

  has_many :following_users, through: :following_relationships, source: :following
  has_many :followed_by_users_accepted, -> { where('relationships.accepted': true) }, through: :followed_by_relationships, source: :followed_by
  has_many :followed_by_users_pending, -> { where('relationships.accepted': false) }, through: :followed_by_relationships, source: :followed_by

  delegate :find_relationship_following, to: :following_relationships
  delegate :find_relationship_followed_by, to: :followed_by_relationships

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_save :set_photo_url

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name[0...12]
      user.photo_url = auth.info.image
    end
  end

  def feed_user_ids
    self.following_user_ids << self.id
  end

  private

  def set_photo_url
    self.photo_url = self.gravatar_photo_url if self.photo_url.nil?
  end

  def gravatar_photo_url
    "https://gravatar.com/avatar/" +
      Digest::SHA256.hexdigest(self.email)
  end
end
