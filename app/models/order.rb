class Order < ApplicationRecord

  enum status: {
    ordered: "ordered",
    paid: "paid",
    cancelled: "cancelled",
    completed: "completed"
  }

  has_many :order_items
end
