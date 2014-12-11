class AddPublishedToOffer < ActiveRecord::Migration
  def change
    add_column :offers, :published, :boolean
  end
end
