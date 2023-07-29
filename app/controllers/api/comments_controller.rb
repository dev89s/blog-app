class Api::CommentsController < ApplicationController
  skip_before_action :verify_authenticity_token, if: -> { request.format.json? }
  def index
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])
    comments = post.comments
    render json: comments
  end

  def show
    post = Post.includes(:comments).find(params[:post_id])
    @comment = post.comments.find(params[:id])
    render json: @comment
  end

  def create
    user = User.find(params[:user_id])
    post = Post.find(params[:post_id])
    comment = Comment.new(author_id: user.id, post_id: post.id, text: params[:text])

    if comment.save
      render json: comment, status: :created
    else
      render json: comment.errors, status: :unprocessable_entity
    end
  end

  def comment_params
    params.require(:comment).permit(:text)
  end
end
