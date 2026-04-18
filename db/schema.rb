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

ActiveRecord::Schema[8.1].define(version: 2026_04_18_102408) do
  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "record_tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "record_id", null: false
    t.integer "tag_id", null: false
    t.datetime "updated_at", null: false
    t.index ["record_id"], name: "index_record_tags_on_record_id"
    t.index ["tag_id"], name: "index_record_tags_on_tag_id"
  end

  create_table "records", force: :cascade do |t|
    t.integer "amount"
    t.integer "category_id", null: false
    t.datetime "created_at", null: false
    t.date "date"
    t.string "income_or_expense"
    t.text "memo"
    t.datetime "updated_at", null: false
    t.integer "user_id", null: false
    t.index ["category_id"], name: "index_records_on_category_id"
    t.index ["user_id"], name: "index_records_on_user_id"
  end

  create_table "tags", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "record_tags", "records"
  add_foreign_key "record_tags", "tags"
  add_foreign_key "records", "categories"
  add_foreign_key "records", "users"
end
