class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.integer :minutes
      t.float :increase_percent
      t.float :reduction_percent
      t.integer :jpy
      t.decimal :bitcoin, precision: 20, scale: 8
      t.decimal :buy_count, precision: 20, scale: 8
      t.decimal :shell_count, precision: 20, scale: 8

      t.timestamps
    end
  end
end
