class CreateEventTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :event_types do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.integer :min_capacity
      t.integer :max_capacity
      t.integer :duration_minutes
      t.text :menu_text
      t.boolean :has_alcoholic_beverages, default: false
      t.boolean :has_decorations, default: false
      t.boolean :has_parking_service, default: false
      t.string :venue_options
      t.references :buffet, null: false, foreign_key: true

      t.timestamps null: false
    end
  end
end
