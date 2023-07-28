class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  ROLES = %i[admin default].freeze

  def admin?
    role == "admin"
  end

  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :likes, foreign_key: :author_id, dependent: :destroy
  has_many :comments, foreign_key: :author_id, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post, dependent: :destroy
  has_many :commented_posts, through: :comments, source: :post, dependent: :destroy
  attribute :posts_counter, :integer, default: 0
  attribute :role, :string, default: 'default'
  attribute :photo, :string, default: 'https://www.nicepng.com/png/detail/806-8061298_jacques-mestre-generic-male-profile.png'

  validates :name, presence: true
  validates :posts_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  def recent_posts
    posts.limit(3).order(updated_at: :desc)
  end
end
