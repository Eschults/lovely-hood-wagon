class AddAddressVerifiedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :address_verified, :boolean
  end
end
