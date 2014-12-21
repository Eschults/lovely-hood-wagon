class RemovePublicFromOffer < ActiveRecord::Migration
  def change
    remove_column :offers, :public, :boolean
  end
end
