class AddQuantityAndTotalAmountToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :quantity, :integer
    add_column :products, :total_amount, :integer
  end
end
