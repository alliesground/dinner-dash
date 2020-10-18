class ApplicationController < ActionController::Base
  before_action :get_cart

  def set_flash_message(msg)
    response.set_header('Flash-Message',msg ) 
  end

  private

  def get_cart
    @cart = Cart.find(session[:cart_id])
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end
