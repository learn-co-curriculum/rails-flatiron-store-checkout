class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def new
  end

  def create
    @order = Order.new_from_cart(current_cart, params[:stripeEmail], params[:stripeToken])
    if @order.process!
      binding.pry
      session[:cart_id] = nil
      redirect_to order_path(@order), notice: 'Thanks for your order!'
    else
      flash[:error]
      redirect_to charges_path
    end
  end
  
end
