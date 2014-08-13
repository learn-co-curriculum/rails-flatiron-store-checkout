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

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to charges_path

  end
end
