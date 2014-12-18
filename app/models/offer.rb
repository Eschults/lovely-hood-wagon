class Offer < ActiveRecord::Base
  belongs_to :user

  has_many :bookings
  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>" }

  validates_presence_of :user, :nature, :type_of_offer, :description
  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  include AlgoliaSearch

  algoliasearch index_name: "#{self}#{ENV['ALGOLIA_SUFFIX']}" do
    # associated index settings can be configured from here

    attributesToIndex ['nature', 'description']

    attributesForFaceting [ 'type_of_offer' ]

    add_attribute :_geoloc do
      { lat: user.latitude, lng: user.longitude }
    end

    add_index "Offer#{ENV['ALGOLIA_SUFFIX']}_daily_price_asc" do
      attributesToIndex ['nature', 'description']

      attributesForFaceting [ 'type_of_offer' ]

      add_attribute :_geoloc do
        { lat: user.latitude, lng: user.longitude }
      end
    end
  end

  def one_price
    if self.type_of_offer == "service"
      if self.hourly_price
        "#{self.hourly_price}€/ heure"
      end
    elsif self.type_of_offer == "rent"
      if self.weekly_price
        "#{self.weekly_price}€/ semaine"
      end
      if self.daily_price
        "#{self.daily_price}€/ jour"
      end
    else
      if self.price
        "#{self.price}€"
      end
    end
  end

  def available?(first_day, last_day)
    output = true
    if self.bookings
      self.bookings.each do |booking|
        if ((booking.start_date..booking.end_date).include? first_day) || ((booking.start_date..booking.end_date).include? last_day)
          output = false
          break
        end
      end
    end
    output
  end
end
