class Order < ActiveRecord::Base  
  belongs_to :cart
  has_many :items, through: :cart
  has_one :stripe_payment

  attr_accessor :stripe_email, :stripe_token

  def process_payment(payment_processor = StripePayment.new)
    @stripe = payment_processor
    if @stripe.process(stripe_email, stripe_token, cart.total)
      true
    else
      errors.add(:total, "invalid stripe payment") #not working
      false
    end
  end

  def self.new_from_cart(cart, stripe_email, stripe_token)
    self.new(
      cart_id: cart.id,
      total: cart.total,
      stripe_email: stripe_email,
      stripe_token: stripe_token
    )
  end

  def process_and_save!
    if self.process_payment
      self.save
      # @stripe.update(order_id: self.id)
      self.change_order_status
      self.change_inventory
    else
      false
    end
  end

  def change_order_status
    self.update(status: "submitted") 
  end

  #This should really be in the item model
  def change_inventory
    if self.status = "submitted"
      self.cart.line_items.each do |line_item| 
        line_item.item.inventory -= line_item.quantity
        line_item.item.save
      end
    end 
  end
end
