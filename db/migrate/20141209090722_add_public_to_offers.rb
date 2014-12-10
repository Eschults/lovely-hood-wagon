class AddPublicToOffers < ActiveRecord::Migration
  def change
    add_column :offers, :public, :boolean
  end
end
