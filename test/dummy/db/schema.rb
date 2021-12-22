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

ActiveRecord::Schema.define(version: 2021_12_19_162435) do

  create_table "mybooks_accounts", force: :cascade do |t|
    t.string "uuid"
    t.integer "book_id", null: false
    t.string "name"
    t.string "account_type"
    t.string "code"
    t.string "description"
    t.boolean "placeholder"
    t.boolean "contra"
    t.integer "parent_id"
    t.integer "level"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_mybooks_accounts_on_book_id"
  end

  create_table "mybooks_books", force: :cascade do |t|
    t.string "name"
    t.string "root"
    t.string "assets"
    t.string "equity"
    t.string "liabilities"
    t.string "income"
    t.string "expenses"
    t.string "checking"
    t.string "savings"
    t.text "settings"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "mybooks_entries", force: :cascade do |t|
    t.integer "book_id", null: false
    t.string "numb"
    t.date "post_date"
    t.string "description"
    t.string "fit_id"
    t.integer "lock_version"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["book_id"], name: "index_mybooks_entries_on_book_id"
  end

  create_table "mybooks_splits", force: :cascade do |t|
    t.integer "account_id", null: false
    t.integer "entry_id", null: false
    t.string "memo"
    t.string "action"
    t.string "reconcile_state"
    t.date "reconcile_date"
    t.integer "amount"
    t.integer "lock_version"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["account_id"], name: "index_mybooks_splits_on_account_id"
    t.index ["entry_id"], name: "index_mybooks_splits_on_entry_id"
  end

  add_foreign_key "mybooks_accounts", "books"
  add_foreign_key "mybooks_entries", "books"
  add_foreign_key "mybooks_splits", "accounts"
  add_foreign_key "mybooks_splits", "entries"
end
