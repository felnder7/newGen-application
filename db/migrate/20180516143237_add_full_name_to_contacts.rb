class AddFullNameToContacts < ActiveRecord::Migration[5.1]
  def change
    add_column :contacts, :full_name, :string
  end
end
