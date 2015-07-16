class AddCommentNotifToUsers < ActiveRecord::Migration
  def change
    add_column :users, :comment_notif, :boolean
  end
end
