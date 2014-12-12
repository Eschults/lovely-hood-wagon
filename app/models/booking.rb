class Booking < ActiveRecord::Base
  belongs_to :offer
  belongs_to :user

  validates_presence_of :offer, :user, :start_date
end
