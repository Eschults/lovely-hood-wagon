class Booking < ActiveRecord::Base
  after_create :send_book_email
  after_update :send_answer_email

  belongs_to :offer
  belongs_to :user
  has_many :reviews

  validates_presence_of :offer, :user, :start_date

  def booking_price
    if offer.type_of_offer == "rent"
      if offer.weekly_price && (end_date - start_date) >= 7
        (end_date - start_date).to_i * offer.weekly_price.fdiv(7)
      else
        (end_date - start_date).to_i * offer.daily_price
      end
    elsif offer.type_of_offer == "service"
      if end_date == start_date
        (end_hour.to_i - start_hour.to_i) / 3_600 * offer.hourly_price
      else
        (((end_hour - Time.new(2000, 01, 01, 0, 0, 0, "+00:00")).to_i + (Time.new(2000, 01, 02, 0, 0, 0, "+00:00") - start_hour).to_i) + (((end_date - start_date).to_i - 1) * 24)) / 3_600 * offer.hourly_price
      end
    end
  end

  private

  def send_book_email
    BookingMailer.book(self).deliver
  end

  def send_answer_email
    if client_validation
      BookingMailer.review(self).deliver
    elsif owner_validation
      BookingMailer.confirm(self).deliver
    elsif self.accepted
      BookingMailer.accept(self).deliver
    else
      BookingMailer.decline(self).deliver
    end
  end
end
