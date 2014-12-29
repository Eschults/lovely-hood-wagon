class AddSellToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :sell, :boolean
  end
end
