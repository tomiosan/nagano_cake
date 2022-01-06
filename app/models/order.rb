class Order < ApplicationRecord
  after_update :check_order_detail
  
  belongs_to :customer
  has_many :order_details, dependent: :destroy
end
