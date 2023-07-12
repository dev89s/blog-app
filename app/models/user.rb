class User < ApplicationRecord
  has_many :posts
  has_many :likes
  has_many :comments
  has_many :posts through: :likes
  has_many :posts through: :comments
end
