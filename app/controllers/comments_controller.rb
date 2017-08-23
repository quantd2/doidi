class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:destroy, :update]
  before_action :find_owner, only: :index

  def index
    @comments = @user.comments.page params[:page]
  end

  def create
    @comment = current_user.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_back fallback_location: :back, notice: "Cám ơn lời bình của bạn." }
        format.js
      else
        format.html { redirect_back fallback_location: :back, alert: "Vui lòng thử lại sau."}
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

  def find_owner
  @user = User.find(user_params)
  end

  def user_params
    params.require(:user_id)
  end
end
