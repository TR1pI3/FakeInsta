class LikesController < ApplicationController
  before_action :find_post

  def create
    @post.likes.create(user_id: current_user.id)
    redirect_to posts_path, notice: 'You liked post!'
  end

  def destroy
    @like = @post.likes.find(params[:id])
    @like.destroy
    redirect_to posts_path, notice: 'You unliked post!'
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end
end
