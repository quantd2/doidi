class Admin::DashboardController < ApplicationController
  before_filter :authenticate_user!, :admin?
  # layout: false

  def index
  end
end
