class AddFreezedToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :freezed, :boolean
  end
end
