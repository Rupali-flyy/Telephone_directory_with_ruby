class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.string :state
      t.integer :pincode
      t.integer :contact_id

      t.timestamps
    end
  end
end
