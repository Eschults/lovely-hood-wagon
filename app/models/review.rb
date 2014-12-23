class Review < ActiveRecord::Base
  belongs_to :booking

  validates_presence_of :booking, :comment, :communication_rating, :punctuality_rating, :recommendation, :review_type
end
