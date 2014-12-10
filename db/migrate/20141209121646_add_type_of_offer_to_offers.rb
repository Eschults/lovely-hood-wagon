class AddTypeOfOfferToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :type_of_offer, :string
  end
end
