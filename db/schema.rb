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

ActiveRecord::Schema.define(version: 2018_08_12_054200) do

  create_table "buy_settings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "minutes"
    t.float "reduction_percent"
    t.integer "jpy"
    t.decimal "buy_count", precision: 20, scale: 8
    t.boolean "is_execution", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "child_order_id"
    t.string "product_code"
    t.string "side"
    t.string "child_order_type"
    t.integer "price"
    t.integer "average_price"
    t.float "size"
    t.string "child_order_state"
    t.datetime "expire_date"
    t.datetime "child_order_date"
    t.string "child_order_acceptance_id"
    t.float "outstanding_size"
    t.float "cancel_size"
    t.float "executed_size"
    t.float "total_commission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sell_settings", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "minutes"
    t.float "increase_percent"
    t.decimal "bitcoin", precision: 20, scale: 8
    t.decimal "sell_count", precision: 20, scale: 8
    t.boolean "is_execution", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "product_code"
    t.datetime "timestamp"
    t.integer "tick_id"
    t.decimal "best_bid", precision: 20, scale: 8
    t.decimal "best_ask", precision: 20, scale: 8
    t.decimal "best_bid_size", precision: 20, scale: 8
    t.decimal "best_ask_size", precision: 20, scale: 8
    t.decimal "total_bid_depth", precision: 20, scale: 8
    t.decimal "total_ask_depth", precision: 20, scale: 8
    t.decimal "ltp", precision: 20, scale: 8
    t.decimal "volume", precision: 20, scale: 8
    t.decimal "volume_by_product", precision: 20, scale: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
