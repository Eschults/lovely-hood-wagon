class Review < ActiveRecord::Base
  belongs_to :booking

  validates_presence_of :booking, :comment, :review_type
end
