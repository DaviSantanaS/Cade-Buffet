class CreatePhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :photos do |t|
      t.references :event_type, null: false, foreign_key: true
      t.string :author
      t.datetime :published_at

      t.timestamps
    end
  end
end
