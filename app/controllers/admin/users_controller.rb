class Admin::UsersController < ApplicationController
  before_action :authenticate_user!, :admin?

  def index
    @users = User.all.page params[:page]
  end

  def destroy
    @user = User.find_by_id(params[:id])
    @user.destroy
    redirect_back fallback_location: :back, notice: "Xoá user thành công."
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
