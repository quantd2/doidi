class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_target, only: [:demand, :deny, :accept, :withhold]

  def new
    @items = current_user.items.page params[:page]
  end

  def demand
    @demander_item = Item.find(relationship_params[:demander_id])
    @demander_item.demand!(@target)
    redirect_to root_path
  end

  def accept
    @demander_item = Item.find(relationship_params[:demander_id])
    @demander_item.accept!(@target)
    respond_to do |format|
      format.html {
        flash[:notice] = 'accpet successfully.'
        redirect_to root_path
      }
    end
  end

  def withhold
    @target.withhold!
    respond_to do |format|
      format.html {
        flash[:notice] = 'khong doi nua.'
        redirect_to item_path(@target)
      }
    end
  end

  def deny
    @demander_item = Item.find(params[:id])
    @demander_item.deny!(@target)
    respond_to do |format|
      format.html {
        flash[:notice] = 'tu choi.'
        redirect_to root_path
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
