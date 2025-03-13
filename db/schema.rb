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

ActiveRecord::Schema[8.0].define(version: 2025_03_11_142656) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name", null: false, comment: "The name of the category"
    t.string "description", comment: "The description of the category"
    t.datetime "deleted_at", comment: "Soft deleted timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "part_options", force: :cascade do |t|
    t.bigint "part_id", null: false, comment: "The part that the option belongs to"
    t.string "name", null: false, comment: "The name of the option"
    t.decimal "price", precision: 8, scale: 2, default: "0.0", null: false, comment: "The price of the option"
    t.datetime "deleted_at", comment: "Soft deleted timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["part_id"], name: "index_part_options_on_part_id"
  end

  create_table "parts", force: :cascade do |t|
    t.string "name", null: false, comment: "The name of the part"
    t.datetime "deleted_at", comment: "Soft deleted timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permission_users", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "permission_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["permission_id"], name: "index_permission_users_on_permission_id"
    t.index ["user_id"], name: "index_permission_users_on_user_id"
  end

  create_table "permissions", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "price_rules", force: :cascade do |t|
    t.bigint "dependent_option_id", null: false, comment: "The option that has specific price rules"
    t.bigint "base_option_id", null: false, comment: "The option that has the base price"
    t.decimal "price_adjustment", precision: 8, scale: 2, default: "0.0", null: false, comment: "The price adjustment for the pair of options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_option_id"], name: "index_price_rules_on_base_option_id"
    t.index ["dependent_option_id"], name: "index_price_rules_on_dependent_option_id"
  end

  create_table "product_parts", force: :cascade do |t|
    t.bigint "product_id", null: false, comment: "The product which the part belongs to"
    t.bigint "part_id", null: false, comment: "The part that the product has"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["part_id"], name: "index_product_parts_on_part_id"
    t.index ["product_id"], name: "index_product_parts_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "category_id", null: false, comment: "The category of the product"
    t.string "name", null: false, comment: "The name of the product"
    t.string "description", comment: "The description of the product"
    t.datetime "deleted_at", comment: "Soft deleted timestamp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "restrictions", force: :cascade do |t|
    t.bigint "dependent_option_id", null: false, comment: "The option that has some restrictions"
    t.bigint "blocked_option_id", null: false, comment: "The option that is blocked for the dependent option"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blocked_option_id"], name: "index_restrictions_on_blocked_option_id"
    t.index ["dependent_option_id"], name: "index_restrictions_on_dependent_option_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.bigint "part_option_id", null: false, comment: "The part option that the stock belongs to"
    t.integer "number_of_units", default: 0, null: false, comment: "The number of units in stock"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["part_option_id"], name: "index_stocks_on_part_option_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "part_options", "parts"
  add_foreign_key "permission_users", "permissions"
  add_foreign_key "permission_users", "users"
  add_foreign_key "price_rules", "part_options", column: "base_option_id"
  add_foreign_key "price_rules", "part_options", column: "dependent_option_id"
  add_foreign_key "product_parts", "parts"
  add_foreign_key "product_parts", "products"
  add_foreign_key "products", "categories"
  add_foreign_key "restrictions", "part_options", column: "blocked_option_id"
  add_foreign_key "restrictions", "part_options", column: "dependent_option_id"
  add_foreign_key "sessions", "users"
  add_foreign_key "stocks", "part_options"
end
