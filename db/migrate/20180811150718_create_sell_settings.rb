class CreateSellSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :sell_settings do |t|
      t.integer :minutes
      t.float :increase_percent
      t.decimal :bitcoin, precision: 20, scale: 8
      t.decimal :sell_count, precision: 20, scale: 8

      t.timestamps
    end
  end
end
