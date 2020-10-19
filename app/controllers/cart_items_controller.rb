class CartItemsController < ApplicationController
  def create
    @cart_item = CartItem.new(
      cart_id: params[:cart_id],
      item_id: params[:item_id]
    )

    if @cart_item.save
      flash[:success] = "Item added to cart"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "something went wrong"
    end
  end
end
