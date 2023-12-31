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

ActiveRecord::Schema[7.0].define(version: 2023_09_06_051917) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "sso_clients", force: :cascade do |t|
    t.string "name", null: false
    t.string "redirect_uri", null: false
    t.string "site_url", null: false
    t.string "token_url", null: false
    t.string "authorize_url", null: false
    t.string "user_info_url", null: false
    t.string "user_info_fields", null: false
    t.string "user_info_id_field", null: false
    t.string "user_info_username_field", null: false
    t.string "user_info_email_field", null: false
    t.string "user_info_first_name_field", null: false
    t.string "user_info_last_name_field", null: false
    t.string "open_id_connect_endpoint", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "username", null: false
    t.string "external_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "provider", limit: 50, default: "", null: false
    t.string "uid", limit: 50, default: "", null: false
    t.boolean "admin", default: false, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

end
