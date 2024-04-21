class CreateBuffetPartyTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :buffet_party_types, id: false do |t|
      t.references :buffet, foreign_key: true
      t.references :party_type, foreign_key: true
    end
  end
end

