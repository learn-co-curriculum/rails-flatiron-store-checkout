class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :cart_id
      t.string :status
      t.decimal :total, :precision => 8, :scale => 2
      t.timestamps
    end
  end
end
