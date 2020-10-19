class CartItemsController < ApplicationController
  def create
    @cart_item = CartItem.new(
      cart_id: @cart.id,
      item_id: params[:item_id]
    )

    if @cart_item.save
      flash[:success] = "Item added to cart"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "something went wrong"
    end
  end

  def destroy_all
    @cart.cart_items.destroy_all
    redirect_back(fallback_location: root_path)
  end
end
