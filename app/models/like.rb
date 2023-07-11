class Like < ApplicationRecord
  belongs_to :posts, counter_cache: :like_count
end
