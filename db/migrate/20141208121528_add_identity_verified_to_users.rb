class AddIdentityVerifiedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :identity_verified, :boolean
  end
end
