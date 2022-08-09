class Post < ApplicationRecord
  has_one_attached :content_image

  has_many :comments, dependent: :destroy
  has_many :users_commented, through: :comments, source: :user

  has_many :likes, dependent: :destroy
  has_many :users_liked, through: :likes, source: :user

  enum scope: {supporter: 0, patron: 1, benefactor: 2}

  def liked?(user)
    !!self.likes.find_by(user_id: user.id)
  end
end
