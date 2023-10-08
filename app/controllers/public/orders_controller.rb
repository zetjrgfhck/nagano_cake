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
    @order.customer_id = current_customer.id
    @order.save  # ordered_itmemの保存
    current_custtomer.cart_items.each do |cart_item|
      @ordered_item = OrderedItem.new #初期化
      @ordered_item.item_id = cart_item.item_id #商品idを注文商品idに代入
      @ordered_item.quantity = cart_item.quantity #商品の個数を注文商品の個数に代入
      @ordered_item.tax_included_price = (cart_item.item.price*1.08).floor #消費税込みに計算して代入
      @ordered_item.order_id =  @order.id #注文商品に注文idを紐付け
      @ordered_item.save #注文商品を保存
    end
      current_customer.cart_items.destroy_all #カートの中身を削除
      redirect_to thanx_orders_path
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_option] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.name

    elsif params[:order][:address_option] == "1"
      ship = Address.find(params[:order][:customer_id])
        @order.postal_code = ship.postal_code
        @order.address = ship.address
        @order.name = ship.name

    elsif params[:order][:address_option] = "2"
      @order.postal_code = params[:order][:postal_code]
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