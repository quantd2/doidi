class Admin::CategoriesController < ApplicationController
  before_action :authenticate_user!, :admin?
  # layout: false

  def index
    @categories = Category.all.page params[:page]
  end

  def show
    @category = Category.find_by_id(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to @category, notice: 'Category was successfully created.'
      # redirect_back fallback_location: :back, notice: "Xoá lời bình thành công."
    else
      render :new
    end
  end

  def destroy
    @category = Category.find_by_id(params[:id])
    @category.destroy
    redirect_back fallback_location: :back, notice: "Xoá đồ thành công."
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end
end
