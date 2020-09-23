class Order < ApplicationRecord

  enum status: {
    ordered: "ordered",
    paid: "paid",
    cancelled: "cancelled",
    completed: "completed"
  }
end
