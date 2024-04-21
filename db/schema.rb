# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_04_21_205623) do
  create_table "buffets", force: :cascade do |t|
    t.string "name", null: false
    t.string "company_name", null: false
    t.string "cnpj", null: false
    t.string "phone", null: false
    t.string "contact_email", null: false
    t.string "address", null: false
    t.string "district", null: false
    t.string "state", null: false
    t.string "city", null: false
    t.string "zip_code", null: false
    t.text "description"
    t.text "payment_methods"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["user_id"], name: "index_buffets_on_user_id"
  end

  create_table "event_prices", force: :cascade do |t|
    t.integer "event_type_id", null: false
    t.integer "buffet_id", null: false
    t.decimal "base_price"
    t.decimal "additional_price_per_person"
    t.decimal "extra_hour_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_event_prices_on_buffet_id"
    t.index ["event_type_id"], name: "index_event_prices_on_event_type_id"
  end

  create_table "event_types", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.integer "min_capacity"
    t.integer "max_capacity"
    t.integer "duration_minutes"
    t.text "menu_text"
    t.boolean "has_alcoholic_beverages", default: false
    t.boolean "has_decorations", default: false
    t.boolean "has_parking_service", default: false
    t.string "venue_options"
    t.integer "buffet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["buffet_id"], name: "index_event_types_on_buffet_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "buffet_owner"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "buffets", "users"
  add_foreign_key "event_prices", "buffets"
  add_foreign_key "event_prices", "event_types"
  add_foreign_key "event_types", "buffets"
end
