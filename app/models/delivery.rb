class Delivery < ApplicationRecord
  belongs_to :customer
  
  def full_addresses
    "〒" + self.postal_code + "  " + self.address + "  " + self.name
  end
end
