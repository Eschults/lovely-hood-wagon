class ChangeDateFormatInBookings < ActiveRecord::Migration
  def change
    change_column :bookings, :start_hour, :time
    change_column :bookings, :end_hour, :time
  end
end
