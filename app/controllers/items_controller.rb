class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :correct_user, only: :destroy
  before_action :find_owner, only: :index
  # GET /items
  # GET /items.json
  def index
    @items = @user.items.paginate(page: params[:page])
  end

  def follower_items
    @items = current_user.items.paginate(page: params[:page])
  end

  def followed_items
    @followed_items = []
    @items = current_user.items.paginate(page: params[:page])
    @items.each do |item|
      @followed_items += item.followed_items
    end
    @followed_items
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])
  end

  # GET /items/new
  def new
    @item = current_user.items.new
    @categories = Category.all
  end

  # GET /items/1/edit
  def edit
    @categories = Category.all
  end

  # POST /items
  # POST /items.json
  def create
    @item = current_user.polls.build(item_params)
    @categories = Category.all
    if @poll.save
      redirect_to url_for(:controller => :welcome, :action => :index), notice: "Tạo thành công nhóm chọn."
    else
      render :new
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        set_image
        format.html {
          redirect_to @item
          flash[:notice] = 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def correct_user
    @poll = current_user.polls.find_by_id(params[:id])
    redirect_to root_path if @poll.nil?
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def item_params
    params.require(:item).permit(:name, :description, :category_id, :image)
  end
end
