class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable,
         :omniauthable, omniauth_providers: [:google_oauth2]

   def self.create_from_provider_data(provider_data)
    where(provider: provider_data.provider, uid: provider_data.uid).first_or_create  do |user|
      user.email = provider_data.info.email
      user.password = Devise.friendly_token[0, 20]
      user.first_name = provider_data.info.first_name
      user.last_name = provider_data.info.last_name
      user.username = "#{user.first_name}#{user.last_name}#{user.uid[0..2]}#{user.uid[5..7]}".downcase.delete(' ')
      user.confirmed_at = Date.current
    end
  end

  enum role: {fan: 0, creator: 1, admin: 2}

  has_many :posts, dependent: :destroy

  has_many :received_follows, foreign_key: :followed_id, class_name: "Follow"
  has_many :followers, through: :received_follows, source: :follower

  has_many :given_follows, foreign_key: :follower_id, class_name: "Follow"
  has_many :followings, through: :given_follows, source: :followed_user
  has_many :following_posts, through: :followings, source: :posts


  def followed?(user)
    !!self.given_follows.find_by(followed_id: user.id)
  end
end
