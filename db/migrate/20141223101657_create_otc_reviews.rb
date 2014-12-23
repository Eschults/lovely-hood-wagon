class CreateOtcReviews < ActiveRecord::Migration
  def change
    create_table :otc_reviews do |t|
      t.text :comment
      t.integer :communication_rating
      t.integer :punctuality_rating
      t.integer :respect_rating
      t.boolean :recommendation
      t.references :booking, index: true

      t.timestamps
    end
  end
end
