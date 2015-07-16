class AddLikeNotifToUsers < ActiveRecord::Migration
  def change
    add_column :users, :like_notif, :boolean
  end
end
