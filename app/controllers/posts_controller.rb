class PostsController < ApplicationController
  before_action :set_post, only: %i[show]
  skip_before_action :authenticate_user!

  def index
    @posts = Post.default_order.preload(:user)
    # todo リファクタする
    @liked_and_post_ids = current_user ? current_user.likes.select(:id, :post_id).map(&:attributes) : []
  end

  def show; end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
