# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_02_12_170629) do

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "number"
    t.string "zip_code"
    t.string "complement"
    t.string "city"
    t.string "state"
    t.integer "carrier_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "neighborhood"
    t.index ["carrier_id"], name: "index_addresses_on_carrier_id"
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "carrier_options", force: :cascade do |t|
    t.float "min_vol"
    t.float "max_vol"
    t.float "price_kg"
    t.integer "carrier_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["carrier_id"], name: "index_carrier_options_on_carrier_id"
  end

  create_table "carriers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "cnpj"
    t.string "corporate_name"
    t.string "address"
  end

  create_table "clients", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.string "address"
    t.string "zip_code"
    t.integer "client_type", default: 0
    t.string "document"
    t.index ["email"], name: "index_clients_on_email", unique: true
    t.index ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.integer "client_id", null: false
    t.integer "status", default: 0
    t.decimal "order_value"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_orders_on_client_id"
  end

  create_table "product_kits", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "width"
    t.integer "height"
    t.integer "thickness"
    t.string "type"
    t.string "sku"
    t.integer "rated_power"
    t.decimal "weight", precision: 5, scale: 2
    t.decimal "purchase_price", precision: 6, scale: 2
    t.decimal "efficiency", precision: 4, scale: 2
    t.integer "max_wattage"
    t.integer "max_voltage"
    t.decimal "max_current", precision: 5, scale: 2
  end

  add_foreign_key "addresses", "carriers"
  add_foreign_key "carrier_options", "carriers"
  add_foreign_key "orders", "clients"
end
