class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :likes, dependent: :destroy
  has_many :posts, through: :likes
  has_many :comments
  has_many :posts
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Relationship', dependent: :destroy
  has_many :followees, through: :followed_users, dependent: :destroy
  has_many :following_users, foreign_key: :followee_id, class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :following_users, dependent: :destroy
  validates :username, presence: true, uniqueness: true, length: {minimum: 5, maximum: 20}
end
