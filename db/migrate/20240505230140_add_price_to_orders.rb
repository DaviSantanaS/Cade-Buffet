class AddPriceToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :price, :decimal, precision: 10, scale: 2
  end
end
