class Admins::OrderDetailsController < ApplicationController
  def update
   @order_detail = OrderDetail.find(params[:id])
    if @order_detail.update(order_detail_params)
      flash[:notice] = "製作ステータスの更新に成功しました"
    end 
    redirect_to admin_order_path(@order_detail.order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

end
