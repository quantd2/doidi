class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_target, only: [:create, :destroy, :accept]

  def new
    @items = current_user.items.page params[:page]
  end

  def create
    @demander_item = Item.find(relationship_params[:demander_id])
    @demander_item.demand!(@target)
    redirect_to root_path
  end

  def accept
    @demander_item = Item.find(relationship_params[:demander_id])
    @demander_item.accept!(@target)
  end

  def destroy
    @demander_item = Item.find(params[:id])
    @demander_item.deny!(@target)
    respond_to do |format|
      format.html {
        flash[:notice] = 'Unfollow successfully.'
        redirect_to :back
      }
    end
  end

  private

  def set_target
    @target = Item.find(relationship_params[:granter_id])
  end

  def relationship_params
    params.require(:relationship).permit(:demander_id, :granter_id)
  end

end
