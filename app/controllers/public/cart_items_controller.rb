class Public::CartItemsController < ApplicationController

  def index
    @cart_item = CartItem.new
    @cart_items = current_customer.cart_items.all
    @total = 0
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      #元々カート内にあるもの「item_id」
      #今追加したparams[:cart_item][:item_id])
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      #cart_item.quantityに今追加したparams[:cart_item][:quantity]を加える #.to_iとして数字として扱う
      cart_item.save
      redirect_to cart_items_path
    elsif @cart_item.save!
      redirect_to cart_items_path
    else# 保存できなかった場合
      @cart_items = current_customer.cart_items.all
      @total = 0
      render 'index'
    end
  end

  def update
    cart_item = CartItem.find(params[:id])
    cart_item.update(cart_item_params)
    redirect_to cart_items_path(cart_item.id)
  end

  def destroy
    @cart_items = Cart_Item.find(params[:id])
    cart_item.destroy
    redirect_to cart_items_path
  end

  def all_destroy
    @cart_items = current_customer.cart_items
    cart_items.destroy_all
    redirect_to cart_items_path
  end


private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end