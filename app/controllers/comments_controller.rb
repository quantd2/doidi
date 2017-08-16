class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy, :update]

  def index
    @item.find_by_id(params[:item_id])
    @comments = @item.comments.page params[:page]
  end

  def create
    @comment = current_user.comments.build(comment_params)
    @comment.save
    respond_to do |format|
      format.html do
        if @comment.errors.present?
          redirect_back fallback_location: :back, notice: "Vui lòng thử lại sau!"
        else
          #@comment.notify_other_commenters
          redirect_to(item_path(@comment.item, :view => "comments"))
        end
      end
      format.js
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: :back, notice: "Xoá lời bình thành công." }
      format.js
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment.update_attributes(comment_params)
    respond_to do |format|
      format.html do
        if @comment.errors.present?
          render :edit
        else
          redirect_to(episode_path(@comment.item, :view => "comments"))
        end
      end
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id, :item_id)
  end

  def correct_user
    @comment = current_user.comments.find_by_id(params[:id])
    redirect_to root_path if @comment.nil?
  end
end
