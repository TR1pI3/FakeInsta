class FeedController < ApplicationController

  def index
    @followees = current_user.followees.includes(:posts).to_a
  end
end