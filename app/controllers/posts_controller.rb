class PostsController < ApplicationController
  before_action :authenticate_user!,:only => [:new, :new_comment, :add_like]

  def index
    @posts = Post.includes(:comments).where(author_id: params[:user_id]).order(updated_at: :desc)
    @user = User.where(id: params[:user_id])[0]
  end

  def show
    @user = User.find(params[:user_id])
    @post = Post.includes(comments: [:author]).where(id: params[:id])[0]
    @comments = @post.comments
  end

  def new
    post = Post.new
    user = User.find(params[:user_id])
    respond_to do |format|
      format.html { render :new, locals: { post:, user: } }
    end
  end

  def create
    post = Post.new(params.require(:post).permit(:title, :text))
    user = current_user
    post.likes_counter = 0
    post.comments_counter = 0
    post.author_id = user.id
    p post
    respond_to do |format|
      format.html do
        if post.save
          flash[:success] = 'Post is saved'
          redirect_to "/users/#{user.id}/posts/"
        else
          flash.now[:error] = "Error: Post didn't save"
          render :new, locals: { post:, user: }
        end
      end
    end
  end

  def new_comment
    comment = Comment.new
    respond_to do |format|
      format.html do
        render :new_comment, locals: { comment:, user: current_user }
      end
    end
  end

  def create_comment
    comment = Comment.new(params.required(:comment).permit(:text))
    comment.author_id = current_user.id
    comment.post_id = Post.find(params[:id]).id
    post = Post.find(params[:id])
    respond_to do |format|
      format.html do
        if comment.save
          flash[:success] = 'Comment is saved'
          redirect_to "/users/#{params[:user_id]}/posts/#{params[:id]}/", locals: { post: }
        else
          flash.now[:error] = "Error: Comment didn't save"
          render :new, locals: { comment:, post: @post, user: }
        end
      end
    end
  end

  def add_like
    post = Post.find(params[:id])
    user = current_user
    like = Like.new(author_id: user.id, post_id: post.id)
    respond_to do |format|
      format.html do
        if like.save
          flash[:success] = 'Post liked!'
          redirect_to "/users/#{params[:user_id]}/posts/#{params[:id]}/", locals: { post: }
        else
          flash.now[:error] = 'Error: Like unsuccessful'
        end
      end
    end
  end
end
