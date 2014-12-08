class CreateOffers < ActiveRecord::Migration
  def change
    create_table :offers do |t|
      t.string :type
      t.string :nature
      t.string :description
      t.integer :hourly_price
      t.integer :daily_price
      t.integer :weekly_price

      t.timestamps
    end
  end
end
