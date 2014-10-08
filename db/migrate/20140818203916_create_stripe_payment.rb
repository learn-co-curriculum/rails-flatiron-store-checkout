class CreateStripePayment < ActiveRecord::Migration
  def change
    create_table :stripe_payments do |t|
      t.integer :order_id
      t.string :stripe_customer_id
      t.string :stripe_email
      t.string :stripe_default_card
      t.string :stripe_charge_id

      t.timestamps
    end
  end
end
