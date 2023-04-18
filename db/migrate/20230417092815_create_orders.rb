class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :order_id
      t.integer :contact_id
      t.integer :product_id

      t.timestamps
    end
    add_index :orders, :order_id, unique: true
  end
end
