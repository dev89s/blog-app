class User < ApplicationRecord
  has_many :posts, foreign_key: :author_id
  has_many :likes, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id
  has_many :liked_posts, through: :likes, source: :post
  has_many :commented_posts, through: :comments, source: :post

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  def recent_posts
    posts.limit(3).order(updated_at: :desc)
  end
end
