class Users::FollowingPostsController < ApplicationController
  def index
    @posts = Post.where(user_id: current_user.following_ids).default_order
  end
end
