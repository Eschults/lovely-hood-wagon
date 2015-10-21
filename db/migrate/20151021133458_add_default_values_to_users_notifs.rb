class AddDefaultValuesToUsersNotifs < ActiveRecord::Migration
  def change
    change_column :users, :comment_notif, :boolean, default: true
    change_column :users, :like_notif, :boolean, default: true
    users = User.all
    users.each do |user|
      unless user.latitude.nil?
        user.comment_notif = true
        user.like_notif = true
        user.save
      end
    end
  end
end
