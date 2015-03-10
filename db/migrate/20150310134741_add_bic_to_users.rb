class AddBicToUsers < ActiveRecord::Migration
  def change
    add_column :users, :bic, :string
  end
end
