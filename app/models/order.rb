class Order < ApplicationRecord
  after_update :check_order_detail
  
  belongs_to :customer
  has_many :order_details, dependent: :destroy
  
  enum status: {
      wating_for_payment: 0,
      confirmed_payment: 1,
      making: 2,
      ready_to_ship: 3,
      sent: 4
   }

   enum payment_method: {
      credit_card: 0,
      transfer: 1
   }


  def set_receiver(receiver)
    self.address = receiver.address
    self.postal_code = receiver.postal_code
    if receiver.is_a?(Customer)
      self.name = receiver.full_name.gsub(" ", "")
    else
      self.name = receiver.name
    end
  end

  def order_products_total_price
    (total_price - 800).round
  end

  def order_products_total_quantity
    self.order_products.sum(:quantity)
  end


  after_create :move_cart_products
  after_update :check_order_detail

  private

  def move_cart_products
    cart_products_list = self.customer.cart_products.map do |cart_product|
      {
        product_id: cart_product.product_id,
        tax_included_price: cart_product.product.add_tax_included_price,
        quantity: cart_product.quantity
      }
    end
    self.order_details.create(cart_products_list)
    self.customer.cart_products.destroy_all
  end

  def check_order_detail
    if self.status == "confirmed_payment"
      self.order_details.update_all(making_status: "wating_for_make")
    end
  end

end
