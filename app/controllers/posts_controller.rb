class PostsController < ApplicationController
  before_action :set_post, only: %i[show]

  def index
    @posts = Post.default_order
  end

  def show; end

  private

  def set_post
    @post = Post.find(params[:id])
  end
end
