class Like < ApplicationRecord
  belongs_to :post, counter_cache: :likes_counter
  belongs_to :author, class_name: 'User'

  after_save :like_counter_update
  def like_counter_update
    post.update(likes_counter: post.likes.count)
  end
end
