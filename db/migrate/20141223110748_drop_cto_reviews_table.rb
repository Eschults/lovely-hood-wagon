class DropCtoReviewsTable < ActiveRecord::Migration
  def change
    drop_table :cto_reviews
  end
end
