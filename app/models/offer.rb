class Offer < ActiveRecord::Base
  belongs_to :user
  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>" }

  validates_presence_of :user, :type_of_offer, :description
  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

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
