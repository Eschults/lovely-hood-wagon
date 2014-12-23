class Booking < ActiveRecord::Base
  after_create :send_book_email
  after_update :send_answer_email

  belongs_to :offer
  belongs_to :user
  has_many :reviews

  validates_presence_of :offer, :user, :start_date

  private

  def send_book_email
    BookingMailer.book(self).deliver
  end

  def send_answer_email
    if self.accepted
      BookingMailer.accept(self).deliver
    else
      BookingMailer.decline(self).deliver
    end
  end
end
