class PostsController < ApplicationController
  def index
    @posts = Post.where(author_id: params[:user_id])
    @user = User.where(id: params[:user_id])[0]
  end

  def show
    @user = User.where(id: params[:user_id])[0]
    @post = Post.includes(:author).where(author_id: params[:user_id], id: params[:id])[0]
    @comments = Comment.where(post_id: params[:id])
  end

  def new
    post = Post.new
    user = current_user
    respond_to do |format|
      format.html { render :new, locals: { post: post, user: user } }
    end
  end

  def create
    post = Post.new(params.require(:post).permit(:title, :text))
    post.likes_counter = 0
    post.comments_counter = 0
    post.author_id = current_user.id
    respond_to do |format|
      format.html do
        if post.save
          flash[:success] = "Post is saved"
          redirect_to "/users/#{current_user.id}/posts/"
        else
          flash.now[:error] = "Error: Post didn't save"
          render :new, locals: { post: post, user: current_user }
        end
      end
    end
  end
end
