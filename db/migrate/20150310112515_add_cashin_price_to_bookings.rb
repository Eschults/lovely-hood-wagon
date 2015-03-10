class AddCashinPriceToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :cashin_price, :float
  end
end
