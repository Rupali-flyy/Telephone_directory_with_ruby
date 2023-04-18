class AddPartNumberToProducts < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      change_table :orders do |t|
        dir.up   { t.change :order_id, :string }
        dir.down { t.change :order_id, :integer }
      end
    end
  end
end
