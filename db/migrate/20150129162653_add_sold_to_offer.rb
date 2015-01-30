class AddSoldToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :sold, :boolean
  end
end
