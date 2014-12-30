class AddOwnerValidationToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :owner_validation, :boolean
  end
end
