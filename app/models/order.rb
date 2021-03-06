class Order < ApplicationRecord

  enum status: {
    ordered: "ordered",
    paid: "paid",
    cancelled: "cancelled",
    completed: "completed"
  }

  has_many :order_items
  has_many :items, through: :order_items

  belongs_to :user

  def self.find_by_status(status)
    if statuses.keys.include?(status)
      where(status: status)
    else
      all
    end
  end

  def subtotal
    items.pluck(:price, :id).inject(0) do |subtotal, item|
      subtotal + (item[0] * OrderItem.quantity_for(id, item[1]))
    end
  end
end
