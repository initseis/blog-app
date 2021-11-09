class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, foreign_key: 'author_id', class_name: 'Post', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', class_name: 'Comment', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', class_name: 'Like', dependent: :destroy
  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def admin?
    self.role == 'Admin'
  end

  def self.most_recent_posts(user)
    Post.joins(:author).where(author: { id: user.id }).order(created_at: :desc).limit(3)
  end
end
