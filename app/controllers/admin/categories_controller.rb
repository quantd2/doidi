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
    @category = Category.new(:parent_id => params[:parent_id])
  end

  def create
    @category = Category.new category_params
    if @category.save
      redirect_to admin_categories_path, notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(category_params)
      redirect_to admin_categories_path, notice: 'Category was successfully edited.'
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find_by_id(params[:id])
    @category.destroy
    redirect_back fallback_location: :back, notice: "Category was successfully destroyed."
  end

  private

  def category_params
    params.require(:category).permit(:name, :parent_id)
  end
end
