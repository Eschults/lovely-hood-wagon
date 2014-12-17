class RemoveTypeFromOffers < ActiveRecord::Migration
  def change
    remove_column :offers, :type, :string
  end
end
