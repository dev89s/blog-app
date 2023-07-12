class Post < ApplicationRecord
  belongs_to :author, counter_cache: :posts_counter, class_name: 'User'
  has_many :likes, foreign_key: :post_id
  has_many :comments, foreign_key: :post_id
  # has_many :users, through: :likes
  # has_many :users, through: :comments
end
