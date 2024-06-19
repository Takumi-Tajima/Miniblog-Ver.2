class Users::FollowingPostsController < ApplicationController
  def index
    @posts = Post.where(user_id: current_user.following_ids).default_order
    @liked_post_ids = current_user&.likes&.pluck(:post_id)
  end
end
