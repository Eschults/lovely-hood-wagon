class AddCancelledToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :cancelled, :boolean
  end
end
