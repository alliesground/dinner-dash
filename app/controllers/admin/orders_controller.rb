class Admin::OrdersController < Admin::ApplicationController
  before_action :set_order, only: [:show, :update]

  def index
    @orders = Order.find_by_status(params[:status])
  end

  def show; end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.js do
          set_flash_message('Order updated successfully')
        end
      else
        format.js do
          set_flash_message("Error!")
        end
      end
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(
      :status
    )
  end
end
