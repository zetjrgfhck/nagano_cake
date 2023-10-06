class Public::OrdersController < ApplicationController

  def index
    @orders = current_customer.orders
  end

  def new
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def create
  end

  def confirm
  end

  def thanks
  end


 private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method)
  end

end
