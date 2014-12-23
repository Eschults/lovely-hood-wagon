class RenameOtcReviewsToReviews < ActiveRecord::Migration
  def change
    rename_table :otc_reviews, :reviews
  end
end
