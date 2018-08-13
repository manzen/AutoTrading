class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :child_order_id
      t.string :product_code
      t.string :side
      t.string :child_order_type
      t.integer :price
      t.integer :average_price
      t.float :size
      t.string :child_order_state
      t.datetime :expire_date
      t.datetime :child_order_date
      t.string :child_order_acceptance_id
      t.float :outstanding_size
      t.float :cancel_size
      t.float :executed_size
      t.float :total_commission

      t.timestamps
    end
  end
end
