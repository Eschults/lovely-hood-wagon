class AddCashedInToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :cashed_in, :boolean
  end
end
