class ApplicationController < ActionController::Base
  include CartSessionHelper

  before_action :current_cart

  def set_flash_message(msg)
    response.set_header('Flash-Message',msg ) 
  end
end
