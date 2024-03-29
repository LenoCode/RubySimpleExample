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

ActiveRecord::Schema[7.1].define(version: 2024_01_08_005152) do
  create_table "api_tokens", force: :cascade do |t|
    t.text "token", null: false
    t.integer "user_id", null: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_api_tokens_on_user_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.integer "copies"
    t.integer "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_books_on_author_id"
  end

  create_table "user_roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "xref_user_roles", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "user_role_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_xref_user_roles_on_user_id"
    t.index ["user_role_id"], name: "index_xref_user_roles_on_user_role_id"
  end

  add_foreign_key "api_tokens", "users"
  add_foreign_key "books", "users", column: "author_id"
  add_foreign_key "xref_user_roles", "user_roles"
  add_foreign_key "xref_user_roles", "users"
end
