class Admin::CommentsController < ApplicationController
  before_action :authenticate_user!, :admin?

  def index
    @comments = Comment.all.page params[:page]
  end
end
