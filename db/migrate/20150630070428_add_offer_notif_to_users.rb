class AddOfferNotifToUsers < ActiveRecord::Migration
  def change
    add_column :users, :offer_notif, :boolean
  end
end
