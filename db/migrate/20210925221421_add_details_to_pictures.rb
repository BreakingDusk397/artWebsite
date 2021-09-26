class AddDetailsToPictures < ActiveRecord::Migration[6.1]
  def change
    add_column :pictures, :price, :integer
    add_column :pictures, :stripe_product_id, :string
    add_column :pictures, :stripe_price_id, :string
    add_column :pictures, :currency, :string, default: "usd"
    add_column :pictures, :sales_count, :integer, default: 0, null: false
  end
end
