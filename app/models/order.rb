class Order < ApplicationRecord

  enum status: {
    ordered: "ordered",
    paid: "paid",
    cancelled: "cancelled",
    completed: "completed"
  }

  has_many :order_items

  def self.find_by_status(status)
    if statuses.keys.include?(status)
      where(status: status)
    else
      all
    end
  end
end
