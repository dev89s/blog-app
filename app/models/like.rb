class Like < ApplicationRecord
  belongs_to :posts, counter_cache: :likes_counter
end
