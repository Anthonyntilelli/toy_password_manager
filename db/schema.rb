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

ActiveRecord::Schema.define(version: 2020_05_30_020010) do

  create_table "accounts", force: :cascade do |t|
    t.text "name", null: false
    t.integer "keychain_id", null: false
    t.text "url"
    t.text "username"
    t.text "password"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["keychain_id"], name: "index_accounts_on_keychain_id"
  end

  create_table "keychains", force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "memberships", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "keychain_id", null: false
    t.boolean "admin", null: false
    t.text "invite_status", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["keychain_id"], name: "index_memberships_on_keychain_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "name", null: false
    t.text "email", null: false
    t.string "password_digest", null: false
    t.boolean "dummy_password", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "accounts", "keychains"
  add_foreign_key "memberships", "keychains"
  add_foreign_key "memberships", "users"
end
