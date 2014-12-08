class AddUserToOffer < ActiveRecord::Migration
  def change
    add_reference :offers, :user, index: true
  end
end
