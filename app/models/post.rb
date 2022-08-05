class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :content_image

  has_many :likes, dependent: :destroy
  has_many :users_liked, through: :likes, source: :user

  def liked?(user)
    !!self.likes.find_by(user_id: user.id)
  end
end
