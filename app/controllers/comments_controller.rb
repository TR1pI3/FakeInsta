class CommentsController < ApplicationController
  before_action :set_post, only: [:new, :create, :destroy]

  def new
    @comment = @post.comments.new
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to @post
    else
      redirect_to new_post_comment_path, alert: @comment.errors.full_messages[0]
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user == current_user
      @comment.destroy
      redirect_to posts_path, notice: 'Comment was successfully deleted.'
    else
      redirect_to posts_path, alert: 'You do not have permission to delete this comment.'
    end
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
