class Offer < ActiveRecord::Base
  belongs_to :user
  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>" }

  validates_presence_of :user, :type_of_offer, :description
  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  def one_price
    if self.type_of_offer == "service"
      if self.hourly_price
        "#{self.hourly_price} €/ heure"
      end
    elsif self.type_of_offer == "rent"
      if self.weekly_price
        "#{self.weekly_price} €/ semaine"
      end
      if self.daily_price
        "#{self.daily_price} €/ jour"
      end
    else
      if self.price
        "#{self.price} €"
      end
    end
  end

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
