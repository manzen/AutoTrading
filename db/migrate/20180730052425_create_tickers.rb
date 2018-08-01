class CreateTickers < ActiveRecord::Migration[5.2]
  def change
    create_table :tickers do |t|
      t.string :product_code
      t.datetime :timestamp
      t.integer :tick_id
      t.decimal :best_bid, precision: 20, scale: 8
      t.decimal :best_ask, precision: 20, scale: 8
      t.decimal :best_bid_size, precision: 20, scale: 8
      t.decimal :best_ask_size, precision: 20, scale: 8
      t.decimal :total_bid_depth, precision: 20, scale: 8
      t.decimal :total_ask_depth, precision: 20, scale: 8
      t.decimal :ltp, precision: 20, scale: 8
      t.decimal :volume, precision: 20, scale: 8
      t.decimal :volume_by_product, precision: 20, scale: 8

      t.timestamps
    end
  end
end
