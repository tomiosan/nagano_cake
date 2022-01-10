class Admins::OrdersController < ApplicationController
  def index
    if params[:customer_id]
     @orders = Order.where(customer_id: params[:customer_id]).page(params[:page]).per(10)
    else
     @orders = Order.all.order(created_at: :desc).page(params[:page]).per(10)
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
    redirect_to admin_order_path(@order)
  end
  
  private

  def order_params
    params.require(:order).permit(:status)
  end

end
