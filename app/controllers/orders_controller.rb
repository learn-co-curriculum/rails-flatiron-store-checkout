class OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
  end

  def create
    @order = Order.new_from_cart(current_cart, params[:stripeEmail], params[:stripeToken])
    if @order.process_and_save!
      session[:cart_id] = nil
      redirect_to order_path(@order), notice: 'Thanks for your order!'
    else
      flash[:notice] = 'Payment failed to process; please try again.'
      redirect_to charges_path
    end
  end
  
end
