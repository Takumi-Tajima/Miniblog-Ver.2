class Posts::LikesController < ApplicationController
  def index
    @liked_users = Post.find(params[:post_id]).liked_users
  end

  def create
    @like_post = current_user.likes.create!(post_id: params[:post_id])
    redirect_to request.referer || root_path
  end

  def destroy
    @like_post = current_user.likes.find_by!(post_id: params[:post_id])
    @like_post.destroy!
    redirect_to request.referer || root_path
  end
end
