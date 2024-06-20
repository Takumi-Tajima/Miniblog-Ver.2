class PostsController < ApplicationController
  before_action :set_post, only: %i[show]
  skip_before_action :authenticate_user!

  def index
    @posts = Post.default_order.preload(:user)
    @liked_post_ids = current_user ? current_user.likes.pluck(:post_id) : []
  end

  def show; end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
