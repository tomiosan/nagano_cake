class Admins::ItemsController < ApplicationController
  def index
     @item = Item.page(params[:page]).per(10)
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(product_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
  end

  private
    def product_params
      params.require(:item).permit(:genre_id, :name, :detail, :image, :tax_excluded_price, :is_active)
    end

end
