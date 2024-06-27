class Users::FollowingPostsController < ApplicationController
  def index
    @posts = Post.where(user_id: current_user.following_ids).default_order
    @liked_and_post_ids = current_user ? current_user.likes.select(:id, :post_id).map(&:attributes) : []
  end
end
