class AddLhPostNotifToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lh_post_notif, :boolean, default: true
  end
end
