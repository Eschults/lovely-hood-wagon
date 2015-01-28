class Review < ActiveRecord::Base
  belongs_to :booking
  after_update :send_view_comment_email

  validates_presence_of :booking, :comment, :review_type

  def cto_score
    (communication_rating + punctuality_rating + quality_price_rating).fdiv(3)
  end

  def otc_score
    (communication_rating + punctuality_rating + respect_rating).fdiv(3)
  end

  private

  def send_view_comment_email
    if review_type == "cto"
      ReviewMailer.view(self, booking.offer.user).deliver
    elsif review_type =="otc"
      ReviewMailer.view(self, booking.user).deliver
    end
  end
end
