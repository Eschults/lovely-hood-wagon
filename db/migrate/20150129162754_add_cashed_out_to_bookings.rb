class AddCashedOutToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :cashed_out, :boolean
  end
end
