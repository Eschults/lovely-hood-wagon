class AddOmniauthToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :picture, :string
    add_column :users, :name, :string
    add_column :users, :token, :string
    add_column :users, :token_expiry, :datetime
  end
end
