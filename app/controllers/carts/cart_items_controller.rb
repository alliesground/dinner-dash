class Carts::CartItemsController < ApplicationController
  def create
    @cart_item = @cart.cart_items.build(item_id: params[:item_id])
    
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

  def destroy_all
    @cart.cart_items.destroy_all
    redirect_back(fallback_location: root_path)
  end
end
