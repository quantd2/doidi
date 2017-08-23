class Admin::ItemsController < ApplicationController
  before_action :authenticate_user!, :admin?

  def index
    @items = Item.all.page params[:page]
  end

  def destroy
    @item = Item.find_by_id(params[:id])
    @item.destroy
    redirect_back fallback_location: :back, notice: "Xoá đồ thành công."
  end

end
