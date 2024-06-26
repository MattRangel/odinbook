class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[github]

  has_one_attached :avatar_image
  scope :for_view, -> { includes(avatar_image_attachment: :blob) }

  validates :bio, length: { maximum: 100 }
  validates :name, length: { maximum: 12 }, presence: true

  has_many :followed_by_relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
  has_many :following_relationships, class_name: "Relationship", foreign_key: "followed_by_id", dependent: :destroy

  has_many :following_users, through: :following_relationships, source: :following
  has_many :followed_by_users_accepted, -> { where('relationships.accepted': true) }, through: :followed_by_relationships, source: :followed_by
  has_many :followed_by_users_pending, -> { where('relationships.accepted': false) }, through: :followed_by_relationships, source: :followed_by

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  before_create :set_def_avatar_url
  after_create -> { UserMailer.with(user: self).welcome_email.deliver_later }

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name[0...12]
      user.photo_url = auth.info.image
    end
  end

  def feed_user_ids
    following_user_ids << id
  end

  def avatar
    avatar_image.attached? ? avatar_image : def_avatar_url
  end

  def find_followed_by_id(user_id)
    followed_by_relationships.detect { |relation| relation.followed_by_id == user_id }
  end

  private

  def set_def_avatar_url
    self.def_avatar_url = gravatar_avatar_url if def_avatar_url.nil?
  end

  def gravatar_photo_url
    "https://gravatar.com/avatar/" +
      Digest::SHA256.hexdigest(email)
  end
end
