class DropPartyTypesAndBuffetPartyTypes < ActiveRecord::Migration[7.1]
  def up
    drop_table :buffet_party_types
    drop_table :party_types
  end

  def down
    create_table :party_types do |t|
      t.string :name, null: false
      t.text :description
      t.timestamps
    end

    create_table :buffet_party_types, id: false do |t|
      t.integer :buffet_id
      t.integer :party_type_id
      t.index [:buffet_id, :party_type_id], unique: true
    end

    add_foreign_key :buffet_party_types, :buffets
    add_foreign_key :buffet_party_types, :party_types
  end
end
