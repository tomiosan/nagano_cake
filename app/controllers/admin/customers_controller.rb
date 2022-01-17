class Admin::CustomersController < ApplicationController
  layout "admin"
  def index
    @customers = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find([params[:id]])
    if customer.update(customer_params)
      redirect_to admins_customer_path(customer)
    else
      redirect_to request.referer
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :phone_number, :email, :is_deleted)
  end

end