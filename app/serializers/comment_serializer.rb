class CommentSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at
  belongs_to :post
end
