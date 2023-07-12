class Comment < ApplicationRecord
  belongs_to :posts, counter_cache: :comments_counter
end
