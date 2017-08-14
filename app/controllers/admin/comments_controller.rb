class Admin::CommentsController < ApplicationController
  before_action :find_commentable, :authenticate_user!, :admin?

  def index
    @comments = Comment.all.includes(:commentable, :reports).page params[:page]
  end

  def create
    @comment = @commentable.comments.new comment_params.merge(user_id: current_user.id)
    respond_to do |format|
      if @comment.save
        format.html { redirect_back fallback_location: :back, info: "Cám ơn bạn đã tham gia bình luận!" }
        format.js
      else
        format.html { redirect_back fallback_location: :back, notice: "Vui lòng thử lại sau!"}
        format.js
      end
    end
  end

  def destroy
    @comment = Comment.find_by_id(params[:id])
    @comment.destroy
    redirect_back fallback_location: :back, notice: "Xoá lời bình thành công."
  end

  def vote
    value = params[:type] == "up" ? 1 : 0
    @comment = Comment.find(params[:id])
    @comment.add_or_update_evaluation(:votes, value, current_user)
    # @commnet.touch
    respond_to do |format|
      format.html { redirect_to :back, info: "Cám ơn bạn đã bầu chọn!" }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :user_id)
  end

  def find_commentable
    @commentable = Comment.find_by_id(params[:comment_id]) if params[:comment_id]
    @commentable = Poll.find_by_id(params[:poll_id]) if params[:poll_id]
  end
end
