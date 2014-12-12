class AddEndHourToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :end_hour, :datetime
  end
end
