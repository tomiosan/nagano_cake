class OrderDetail < ApplicationRecord
  after_update :check_making_status
  
  belongs_to :item
  belongs_to :order
end
