class RelationshipsController < ApplicationController

  def new
    set_item
    @items = current_user.items
  end

  def create
    @items = current_user.items
    @follower_item = Item.find(params[:relationship][:follower_id])
    begin
      @follower_item.follow!(@@item)
    rescue Exception => e
      flash[:alert] = 'the item has followed maximum 3 others.'
    end
    redirect_to root_path
  end

  def destroy
    set_item
    @items = current_user.items
    @follower_item = Item.find(params[:id])
    @follower_item.unfollow!(@@item)
    respond_to do |format|
      format.html {
        flash[:notice] = 'Unfollow successfully.'
        redirect_to :back
      }
    end
  end

  private

  def set_item
    @@item = Item.find(params[:item_id])
  end

  def relationship_params
    params.require(:relationship).permit(:follower_id)
  end

end
