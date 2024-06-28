class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    # @comment = @post.comments.build(comment_params.merge(user: current_user))

    if @comment.save
      # redirect_to @comment == comment_url(@comment) になる
      # post_comment_path(@comment.post, @comment)
      redirect_to post_comment_path(@comment.post, @comment), notice: t('controllers.common.created', model: 'コメント')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment, notice: t('controllers.common.update', model: 'コメント'), status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy!
    redirect_to comments_url, notice: t('controllers.common.destroyed', model: 'コメント'), status: :see_other
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
