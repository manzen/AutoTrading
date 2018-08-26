class CreateExecutions < ActiveRecord::Migration[5.2]
  def change
    create_table :executions do |t|
      t.string :child_order_id
      t.string :side
      t.integer :price
      t.float :size
      t.decimal :commission, precision: 20, scale: 8
      t.datetime :exec_date
      t.string :child_order_acceptance_id

      t.timestamps
    end
  end
end
