class Admin::ItemsController < ApplicationController
  before_action :authenticate_user!, :admin?

  def index
    @items = Item.all.includes(:reports).page params[:page]
  end

  def show
    @item = Item.find_by_id(params[:id])
    @comments = @item.comments.page params[:page]
  end

  def new
    @item = Item.new
  end

  def destroy
    @item = Item.find_by_id(params[:id])
    @item.destroy
    redirect_back fallback_location: :back, notice: "Xoá đồ thành công."
  end

  private

  def item_params
    params.require(:item).permit(:name, :user_id)
  end
end
