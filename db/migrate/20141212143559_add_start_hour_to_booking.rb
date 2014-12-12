class AddStartHourToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :start_hour, :datetime
  end
end
