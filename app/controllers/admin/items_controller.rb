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

  def edit
    @item = Item.find params[:id]
  end

  def update
    @item = Item.find params[:id]
    respond_to do |format|
      if @item.update(item_params)
        format.html {
          redirect_to @item
          flash[:notice] = 'Sửa thành công món đồ.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:name, :description, :image, :category_id, :location_id)
  end

end
