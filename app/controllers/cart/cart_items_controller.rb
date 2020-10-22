class Cart::CartItemsController < ApplicationController
  def index
    @cart_items = current_cart.cart_items
  end

  def create
    @cart_item = current_cart.cart_items.build(item_id: params[:item_id])
    
    respond_to do |format|
      if @cart_item.save
        format.js do
          set_flash_message('Item added to cart')
        end
      else
        format.js do
          set_flash_message('something went wrong')
        end
      end
    end
  end

  def update
    @cart_item = CartItem.find_by(id: params[:id])

    respond_to do |format|
      unless @cart_item.update(cart_item_params)
        format.js do
          set_flash_message('could not update cart item')
        end
      else
        format.js
      end
    end
  end

  def destroy
    cart_item = CartItem.find_by(id: params[:id])
    cart_item.delete if cart_item
    redirect_back(fallback_location: root_path)
  end

  def destroy_all
    current_cart.cart_items.destroy_all
    redirect_back(fallback_location: root_path)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
