class AddPaymentAndAdjustmentDetailsToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :payment_method, :string
    add_column :orders, :price_adjustment_description, :text
    add_column :orders, :price_adjustment, :decimal, precision: 10, scale: 2
  end
end
