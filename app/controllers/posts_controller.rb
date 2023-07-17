class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    @user = User.where(id: params[:user_id])[0]
  end

  def show
    @user = User.where(id: params[:user_id])[0]
    @post = Post.includes(:author).where(author_id: params[:user_id], id: params[:id])[0]
  end
end
