class ApplicationController < ActionController::Base
  include CartSessionHelper

  before_action :get_cart

  def set_flash_message(msg)
    response.set_header('Flash-Message',msg ) 
  end

  private

  def get_cart
    current_cart
  end
end
