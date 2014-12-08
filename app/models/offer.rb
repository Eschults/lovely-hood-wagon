class Offer < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user, :type, :nature, :description

  # def available?(first_day, last_day)
  #   output = true
  #   if self.bookings
  #     self.bookings.each do |booking|
  #       if ((booking.start_date..booking.end_date).include? first_day) || ((booking.start_date..booking.end_date).include? last_day)
  #         output = false
  #         break
  #       end
  #     end
  #   end
  #   output
  # end
end
