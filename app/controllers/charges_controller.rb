class ChargesController < ApplicationController

  def new
  end

  def create
    @amount = (current_cart.total * 100).to_i
    customer = Stripe::Customer.create(
      email: params[:email],
      card: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: current_cart.id,
      currency: 'usd'
    )

    @order = Order.create_from_cart(current_cart)
    @order.change_order_status
    @order.change_inventory
    session[:cart_id] = nil
    redirect_to order_path(@order), notice: 'Thanks for your order!'

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path

  end
end
