class Post < ApplicationRecord
  belongs_to :author, counter_cache: :posts_counter, class_name: 'User'
  has_many :likes, foreign_key: :post_id
  has_many :comments, foreign_key: :post_id

  after_save :post_counter_update
  def post_counter_update
    author.update(posts_counter: author.posts.count)
  end

  def recent_comments
    comments.limit(5).order(created_at: :desc)
  end
end
