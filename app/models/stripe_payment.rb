class StripePayment < ActiveRecord::Base
  belongs_to :order

  def create_customer(email, stripe_token)
    Stripe::Customer.create(
      :email => email,
      :card  => stripe_token
    )
  end

  def store_customer_information
  end

  def store_charge_information
  end

  def create_charge(amount)
    Stripe::Charge.create(
      customer: @customer.id,
      amount: amount,
      description: @customer.id,
      currency: 'usd'
    )
  end

  def process(email, stripe_token, amount)
    @customer ||= create_customer(email, stripe_token)
    create_charge(amount)
  end

end
