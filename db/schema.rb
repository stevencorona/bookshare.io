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

ActiveRecord::Schema.define(version: 20140320210007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "isbn"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "notes"
    t.text     "description"
    t.string   "author"
    t.integer  "pages"
    t.integer  "published_year"
    t.integer  "category_id"
    t.integer  "ratings_count",  default: 0
    t.float    "average_rating", default: 0.0
  end

  add_index "books", ["category_id"], name: "index_books_on_category_id", using: :btree
  add_index "books", ["isbn"], name: "index_books_on_isbn", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.integer  "order_id"
    t.string   "book_isbn"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "items", ["book_isbn"], name: "index_items_on_book_isbn", using: :btree
  add_index "items", ["order_id"], name: "index_items_on_order_id", using: :btree

  create_table "orders", id: :uuid, default: "uuid_generate_v4()", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "country"
    t.string   "token"
    t.integer  "total_amount"
    t.integer  "donation_amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
  end

  add_index "orders", ["email"], name: "index_orders_on_email", using: :btree

end
