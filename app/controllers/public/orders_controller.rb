class Public::OrdersController < ApplicationController

  def index
    @orders = current_customer.orders
  end

  def new
    @order = Order.new
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end

  def create
    @order = Order.new(order_params)
    @order.save
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    
    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:customer_id])
        @order._postal_code = ship.postal_code
        @order.address = ship.address
        @order.name = ship.name 
        
    elsif params[:order][:address_option] = "2"
      @order._postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    else
      render 'new'
    end
    @cart_items = current_customer.cart_items.all
  end

  def thanks
  end


 private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method)
  end

end