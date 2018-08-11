class CreateBuySettings < ActiveRecord::Migration[5.2]
  def change
    create_table :buy_settings do |t|
      t.integer :minutes
      t.float :reduction_percent
      t.integer :jpy
      t.decimal :buy_count, precision: 20, scale: 8

      t.timestamps
    end
  end
end
