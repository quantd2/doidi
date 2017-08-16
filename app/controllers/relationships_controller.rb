class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_target, only: [:create, :destroy]

  def new
    @items = current_user.items.page params[:page]
  end

  def create
    @follower_item = Item.find(params[:relationship][:follower_id])
    @follower_item.follow!(@target)
    redirect_to root_path
  end

  def destroy
    @follower_item = Item.find(params[:id])
    @follower_item.unfollow!(@target)
    respond_to do |format|
      format.html {
        flash[:notice] = 'Unfollow successfully.'
        redirect_to :back
      }
    end
  end

  private

  def set_target
    @target = Item.find(params[:item_id])
  end

  def relationship_params
    params.require(:relationship).permit(:follower_id)
  end

end
