class PostsController < ApplicationController
  def index
    @posts = Post.all.includes(:comments, :likes).to_a
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created'
    else
      render :new, alert: 'Post could not be created'
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path, notice: 'Post was successfully updated'
    else
      render :edit, alert: 'Post could not be updated'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    return unless @post.destroy

    redirect_to posts_path, notice: 'Post was successfully deleted'
  end

  private

  def post_params
    params.require(:post).permit(:body, :image)
  end
end
