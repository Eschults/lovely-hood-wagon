class AddUserNotifToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_notif, :boolean
  end
end
