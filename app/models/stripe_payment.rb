class StripePayment < ActiveRecord::Base
  # belongs_to :order

  def create_customer(email, stripe_token)
    Stripe::Customer.create(
      :email => email,
      :card  => stripe_token
    )
  end

  def create_charge(amount)
    Stripe::Charge.create(
      customer: @customer.id,
      amount: stripe_price(amount),
      description: @customer.id,
      currency: 'usd'
    )
  end

  def process(email, stripe_token, amount)
    @customer ||= create_customer(email, stripe_token)
    create_charge(amount)
  end

  private
  def stripe_price(price)
    (price * 100).to_i
  end
end
