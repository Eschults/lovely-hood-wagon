class CreateCtoReviews < ActiveRecord::Migration
  def change
    create_table :cto_reviews do |t|
      t.text :comment
      t.integer :communication_rating
      t.integer :punctuality_rating
      t.integer :quality_price_rating
      t.boolean :recommendation
      t.references :booking, index: true

      t.timestamps
    end
  end
end
