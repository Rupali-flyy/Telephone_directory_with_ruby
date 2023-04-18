class CreateContacts < ActiveRecord::Migration[7.0]
  def change
    create_table :contacts do |t|
      t.string :name
      t.integer :age
      t.boolean :is_active
      t.string :phone_number
      t.string :address

      t.timestamps
    end
  end
end

