class AddConfirmedByClientToOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :orders, :confirmed_by_client, :boolean
  end
end
