class Users::LikesController < ApplicationController
  def create
    @like_post = Like.new(user_id: current_user.id, post_id: params[:post_id])
    @like_post.save
    redirect_to request.referer || root_path
  end

  def destory!
    @like_post = current_user.likes.find_by(post_id: params[:post_id])
    @like_post.destroy!
    redirect_to request.referer || root_path
  end
end
