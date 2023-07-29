class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :surname, :email
  has_many :posts
end
