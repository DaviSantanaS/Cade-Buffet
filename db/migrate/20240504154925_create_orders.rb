class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.references :buffet, null: false, foreign_key: true
      t.references :event_type, null: false, foreign_key: true
      t.date :event_date
      t.integer :guest_count
      t.text :details
      t.string :status
      t.string :code
      t.string :alternative_address

      t.timestamps
    end
  end
end
