class AddColumnsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :quality_price_rating, :integer
    add_column :reviews, :review_type, :string
  end
end
