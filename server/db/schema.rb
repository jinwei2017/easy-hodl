# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20170817070654) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "transactions", force: :cascade do |t|
    t.datetime "timestamp",      null: false
    t.string   "transaction_id", null: false
    t.string   "currency",       null: false
    t.integer  "amount",         null: false
    t.integer  "saved",          null: false
    t.string   "description",    null: false
    t.integer  "user_id",        null: false
  end

  add_index "transactions", ["transaction_id"], name: "index_transactions_on_transaction_id", unique: true, using: :btree
  add_index "transactions", ["user_id"], name: "index_transactions_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string "truelayer_access_token",  null: false
    t.string "truelayer_refresh_token", null: false
    t.string "truelayer_id",            null: false
    t.string "kraken_key"
    t.string "kraken_secret"
  end

  add_index "users", ["truelayer_id"], name: "index_users_on_truelayer_id", unique: true, using: :btree

  add_foreign_key "transactions", "users"
end
