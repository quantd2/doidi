class CommentsController < ApplicationController
  before_action :find_commentable, :authenticate_user!, except: [:show, :index]
  before_action :correct_user, only: :destroy
  before_action :find_owner, only: :index

  def index
    @item.find_by_id(params[:item_id])
    @comments = @item.comments.page params[:page]
  end

  def new
    comment = Comment.new(:parent_id => params[:parent_id], :item_id => params[:item_id], :user => current_user)
  end

  def create
    @comment = Comment.new comment_params.merge(user_id: current_user.id, item_id: params[:item_id])
    respond_to do |format|
      if @comment.save
        format.html { redirect_back fallback_location: :back, info: "Cám ơn bạn đã tham gia bình luận!" }
        format.js
      else
        Rails.logger.error @comment.errors.full_messages
        format.html { redirect_back fallback_location: :back, notice: "Vui lòng thử lại sau!"}
        format.js
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: :back, notice: "Xoá lời bình thành công." }
      format.js
    end
  end

  def vote
    value = params[:type] == "up" ? 1 : 0
    @comment = Comment.find(params[:id])
    @comment.add_or_update_evaluation(:votes, value, current_user)
    @comment.touch
    respond_to do |format|
      format.html { redirect_to :back, info: "Cám ơn bạn đã bầu chọn!" }
      format.js
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :parent_id)
  end

  def find_commentable
    if params[:comment_id]
      @commentable = Comment.find_by_id(params[:comment_id])
      @item_id = @commentable.item_id
    elsif params[:item_id]
      @commentable = Item.find_by_id(params[:item_id])
      @item_id = @commentable.id
    end
  end

  def correct_user
    @comment = current_user.comments.find_by_id(params[:id])
    redirect_to root_path if @comment.nil?
  end

  def find_owner
    @user = User.find(user_params)
  end

  def user_params
    params.require(:user_id)
  end
end
