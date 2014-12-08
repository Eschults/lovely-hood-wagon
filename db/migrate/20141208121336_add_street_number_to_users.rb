class AddStreetNumberToUsers < ActiveRecord::Migration
  def change
    add_column :users, :street_number, :string
  end
end
