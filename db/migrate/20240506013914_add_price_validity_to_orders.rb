class AddPriceValidityToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :price_validity, :date
  end
end
