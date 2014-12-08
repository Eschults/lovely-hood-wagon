class AddPriceToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :price, :integer
  end
end
