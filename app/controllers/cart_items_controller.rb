class CartItemsController < ApplicationController
  def create
    @cart_item = CartItem.new(cart_item_params)

    if @cart_item.save
      flash[:success] = "Item added to cart"
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "something went wrong"
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(
      :item_id,
      :cart_id
    )
  end
end
