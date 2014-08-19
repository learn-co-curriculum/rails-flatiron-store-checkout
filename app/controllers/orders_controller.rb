class OrdersController < ApplicationController
  before_action :process_payment, only: [:create]

  def show
    @order = Order.find(params[:id])
  end

  def new
  end

  def create
    @order = Order.new_from_cart(current_cart, params[:stripeEmail], params[:stripeToken])
    if @order.process!
      session[:cart_id] = nil
      redirect_to order_path(@order), notice: 'Thanks for your order!'
    else
      flash[:error] = e.message
      redirect_to charges_path
    end
  end

  private 
  def process_payment

  end
  
end
