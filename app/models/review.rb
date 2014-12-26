class Review < ActiveRecord::Base
  belongs_to :booking

  validates_presence_of :booking, :comment, :review_type

  def cto_score
    (communication_rating + punctuality_rating + quality_price_rating).fdiv(3)
  end
end
