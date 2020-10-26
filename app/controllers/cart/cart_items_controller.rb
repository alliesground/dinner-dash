class Cart::CartItemsController < ApplicationController
  def index
    @cart_items = current_cart.cart_items
  end

  def create
    @cart_item = current_cart.cart_items.build(item_id: params[:item_id])
    
    if @cart_item.save
      flash[:success] = 'Item successfully added to your cart'
      redirect_to cart_cart_items_path
    else
      flash[:alert] = 'Something went wrong'
      redirect_back(fallback_location: root_path)
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
