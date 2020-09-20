class ApplicationController < ActionController::Base
  def set_flash_message(msg)
    response.set_header('Flash-Message',msg ) 
  end
end
