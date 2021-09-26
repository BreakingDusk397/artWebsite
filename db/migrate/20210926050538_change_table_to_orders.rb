class ChangeTableToOrders < ActiveRecord::Migration[6.1]
  def change
    change_table :users do |t|
      t.remove "product_id"
      t.string "shipping_address"
      t.remove "token"
      t.remove "error_message"
      t.string "billing_address"
      t.remove "price_cents"
      t.integer "price"

    end 
  end
end
