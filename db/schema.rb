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

ActiveRecord::Schema.define(version: 2018_07_31_011020) do

  create_table "settings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "minutes"
    t.float "increase_percent"
    t.float "reduction_percent"
    t.integer "increase_conditions"
    t.integer "reduction_conditions"
    t.decimal "buy_count", precision: 10
    t.decimal "shell_count", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "product_code"
    t.datetime "timestamp"
    t.integer "tick_id"
    t.decimal "best_bid", precision: 10
    t.decimal "best_ask", precision: 10
    t.decimal "best_bid_size", precision: 10
    t.decimal "best_ask_size", precision: 10
    t.decimal "total_bid_depth", precision: 10
    t.decimal "total_ask_depth", precision: 10
    t.decimal "ltp", precision: 10
    t.decimal "volume", precision: 10
    t.decimal "volume_by_product", precision: 10
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
