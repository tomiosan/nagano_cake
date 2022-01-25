class Public::DeliveriesController < ApplicationController

  def index
    @delivery = Delivery.new
    @deliveries = current_customer.deliveries.all
  end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    if @delivery.save
      redirect_to deliveries_path ,notice: "新しい配送先を登録しました"
    else
      @deliveries = current_customer.deliveries.all
      flash[:alert] = '配送先の登録に失敗しました'
      render :index
    end
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      redirect_to deliveries_path ,notice: "配送先の情報を変更しました"
    else
      flash[:alert] = '配送先の変更に失敗しました'
      render :edit
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    redirect_to deliveries_path, notice: '1件の配送先を削除しました'
  end

  private

  def delivery_params
    params.require(:delivery).permit(:name,:address,:postal_code)
  end

end
