class Post < ApplicationRecord
  belongs_to :users, counter_cache: :post_count
  has_many :likes
  has_many :comments
end
