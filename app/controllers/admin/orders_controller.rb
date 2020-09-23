class Admin::OrdersController < Admin::ApplicationController
  def index
    @orders = Order.find_by_status(params[:status])
  end

  def show
    @order = Order.find(params[:id])
  end
end
