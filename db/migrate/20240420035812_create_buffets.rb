class CreateBuffets < ActiveRecord::Migration[7.1]
  def change
    create_table :buffets do |t|
      t.string :name, null: false
      t.string :company_name, null: false
      t.string :cnpj, null: false
      t.string :phone, null: false
      t.string :contact_email, null: false
      t.string :address, null: false
      t.string :district, null: false
      t.string :state, null: false
      t.string :city, null: false
      t.string :zip_code, null: false
      t.text :description
      t.text :payment_methods
      t.timestamps
    end
  end
end
