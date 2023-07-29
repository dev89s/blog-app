class CommentsSerializer < ActiveModel::Serializer
  attributes :id, :text, :created_at
end
