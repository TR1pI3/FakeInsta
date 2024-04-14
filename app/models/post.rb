class Post < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :users, through: :likes
  belongs_to :user
  validates :image, presence: true
  validates :body, presence: true, length: { maximum: 450 }


  def liked?(user)
    Like.exists?(user_id: user, post_id: id)
  end
end
