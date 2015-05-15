class ChangeDefaultValueForAuthorizedInUsers < ActiveRecord::Migration
  def change
    change_column :users, :authorized, :boolean, default: true
  end
end
