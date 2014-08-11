class CartsController < ApplicationController
  before_filter :set_cart, only: [:show]

  def show
  end

  def checkout
    @order = Order.create_from_cart(@cart)
    @order.change_order_status
    @order.change_inventory
    session[:cart_id] = nil
  end

  private
  def set_cart
    @cart = Cart.find(params[:id])
  end
end
