class AddContactIdToContacts < ActiveRecord::Migration[7.0]
  def change
    add_column :contacts, :contact_id, :integer
  end
end
