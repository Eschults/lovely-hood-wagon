class AddClientValidationToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :client_validation, :boolean
  end
end
