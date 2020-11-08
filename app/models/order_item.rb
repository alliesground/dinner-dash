class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :item

  def self.quantity_for(order_id, item_id)
    where(order_id: order_id, item_id: item_id).
      pluck(:quantity).
      first
  end
end
