class AddColumnTypeOfUserToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :buffet_owner, :boolean
  end
end
