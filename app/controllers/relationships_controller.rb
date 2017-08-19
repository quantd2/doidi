class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_target

  def new
    @items = current_user.items.joins(:categorizations).where('items.id NOT IN (SELECT granter_id FROM relationships)
                                      AND items.id NOT IN (SELECT demander_id FROM relationships)')
                                      .where('categorizations.category_id = ?', @target.category_ids[0])
                                      .page params[:page]

  end

  def demand
    @demander_item = Item.find(relationship_params[:demander_id])
    @demander_item.demand!(@target)
    redirect_to root_path
  end

  def accept
    @demander_item = Item.find(relationship_params[:demander_id])
    @target.accept!(@demander_item)
    respond_to do |format|
      format.html {
        flash[:notice] = 'Bạn chấp nhận đổi.'
        redirect_to item_path(@target)
      }
    end
  end

  def withhold
    @target.withhold!
    respond_to do |format|
      format.html {
        flash[:notice] = 'Bạn không đổi nữa.'
        redirect_to item_path(@target)
      }
    end
  end

  def deny
    @demander_item = Item.find(params[:id])
    @demander_item.deny!(@target)
    respond_to do |format|
      format.html {
        flash[:notice] = 'Bạn từ chối lời đề nghị'
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
