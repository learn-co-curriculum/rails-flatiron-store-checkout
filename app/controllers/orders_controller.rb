class OrdersController < ApplicationController
  before_action :process_payment, only: [:create]

  def show
    @order = Order.find(params[:id])
  end

  def new
  end

  def create
    @order = Order.create_from_cart(current_cart)
    @order.change_order_status
    @order.change_inventory
    session[:cart_id] = nil
    redirect_to order_path(@order), notice: 'Thanks for your order!'

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path

  end

  private 
  def process_payment
    @stripe = StripePayment.new
    @stripe.process(params[:email], params[:stripeToken], current_cart.total)
  end
  
end
