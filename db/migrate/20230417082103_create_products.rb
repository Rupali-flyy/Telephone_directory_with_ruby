class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :product_name
      t.string :product_type
      t.integer :product_id

      t.timestamps
    end
    add_index :products, :product_id, unique: true
  end
end
