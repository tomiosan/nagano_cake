class Admin::OrdersController < ApplicationController
  layout "admin"
  
  def index
    if params[:customer_id]
     @orders = Order.where(customer_id: params[:customer_id])
    else
     @orders = Order.all
    end
  end

  def show
    @order = Order.find(params[:id])
    @order.postage = 800
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "注文ステータスの更新に成功しました"
    end
    redirect_to admins_order_path(@order)
  end
  
  private

  def order_params
    params.require(:order).permit(:status)
  end

end
