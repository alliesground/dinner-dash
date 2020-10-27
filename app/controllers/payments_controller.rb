class PaymentsController < ApplicationController
  def create
    # make payment with payment client
    # loopback after payment
    # if payment successful

    order = Order.new( status: 'paid')

    current_cart.cart_items.each do |cart_item|
      order.order_items.build(
        item_id: cart_item.item_id,
        quantity: cart_item.quantity
      )
    end

    if order.save
      flash[:success] = 'order placed successfully'
    end

    session.delete(:cart_id)
    redirect_to root_path
  end
end
