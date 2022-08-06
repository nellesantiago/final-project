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
      user.skip_confirmation!
      user.image = provider_data.info.image
    end
  end

  enum role: {fan: 0, admin: 1}

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post

  has_one_attached :content_image

end
