class CreateSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :settings do |t|
      t.integer :minutes
      t.float :increase_percent
      t.float :reduction_percent
      t.integer :increase_conditions
      t.integer :reduction_conditions
      t.decimal :buy_count
      t.decimal :shell_count

      t.timestamps
    end
  end
end
