class AddGuaranteeToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :guarantee, :integer
  end
end
