class Comment < ApplicationRecord
  belongs_to :posts, counter_cache :comment_count
end
