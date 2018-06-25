# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_06_21_131351) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "permissions", force: :cascade do |t|
    t.string "ability"
    t.string "permissable_type", null: false
    t.bigint "permissable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_permissions_on_deleted_at"
    t.index ["permissable_id", "permissable_type", "ability"], name: "index_permissions_on_permissable_and_ability", unique: true
    t.index ["permissable_type", "permissable_id"], name: "index_permissions_on_permissable_type_and_permissable_id"
  end

  create_table "reset_password_tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "body", null: false
    t.boolean "used", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["body"], name: "index_reset_password_tokens_on_body", unique: true
    t.index ["deleted_at"], name: "index_reset_password_tokens_on_deleted_at"
    t.index ["user_id"], name: "index_reset_password_tokens_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_roles_on_deleted_at"
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.bigint "role_id"
    t.string "email", null: false
    t.string "password_digest", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  add_foreign_key "reset_password_tokens", "users"
  add_foreign_key "users", "roles"
end
