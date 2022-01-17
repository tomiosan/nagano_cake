class Admin::HomesController < ApplicationController
  layout "admin"

  def top
    @orders = Order.all
  end
end
