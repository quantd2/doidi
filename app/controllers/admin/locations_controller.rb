class Admin::LocationsController < ApplicationController
  before_action :authenticate_user!, :admin?
  # layout: false

  def index
    @locations = Location.all.page params[:page]
  end

  def show
    @location = Location.find_by_id(params[:id])
  end

  def new
    @location = Location.new(:parent_id => params[:parent_id])
  end

  def create
    @location = Location.new location_params
    if @location.save
      redirect_to admin_locations_path, notice: 'Location was successfully created.'
    else
      render :new
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(location_params)
      redirect_to admin_locations_path, notice: 'Location was successfully edited.'
    else
      render 'edit'
    end
  end

  def destroy
    @location = Location.find_by_id(params[:id])
    @location.destroy
    redirect_to admin_locations_path, notice: "Location was successfully destroyed."
  end

  private

  def location_params
    params.require(:location).permit(:name, :parent_id)
  end
end
