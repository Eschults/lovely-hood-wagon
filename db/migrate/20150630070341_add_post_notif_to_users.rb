class AddPostNotifToUsers < ActiveRecord::Migration
  def change
    add_column :users, :post_notif, :boolean
  end
end
