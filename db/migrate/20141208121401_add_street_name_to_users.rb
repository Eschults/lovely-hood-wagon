class AddStreetNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :street_name, :string
  end
end
