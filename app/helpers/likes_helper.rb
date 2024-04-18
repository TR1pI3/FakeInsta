module LikesHelper
  def liked?(user_id, post_id)
    Like.exists?(user_id:, post_id:)
  end

  def find_user_like(current_user, post)
    post.likes.find_by(user_id: current_user.id)
  end
end
