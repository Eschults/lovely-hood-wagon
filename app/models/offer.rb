class Offer < ActiveRecord::Base
  belongs_to :user

  has_many :bookings
  has_attached_file :picture,
    styles: { large: "600x600#", medium: "300x300#", thumb: "100x100#" }

  acts_as_votable

  validates_presence_of :user, :nature, :type_of_offer, :description
  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  include AlgoliaSearch

  algoliasearch if: :published, index_name: "#{self}#{ENV['ALGOLIA_SUFFIX']}" do
    # associated index settings can be configured from here

    attributesToIndex ['nature', 'description']

    attributesForFaceting [ 'type_of_offer' ]

    add_attribute :_geoloc do
      { lat: user.latitude, lng: user.longitude }
    end

    add_attribute :one_price_int do
      one_price_int
    end

    add_attribute :one_price do
      one_price_int
    end

    add_attribute :picture_url do
      picture.url(:medium)
    end

    add_attribute :large_picture_url do
      picture.url(:large)
    end

    add_attribute :picture? do
      if picture.url(:medium) == "/pictures/medium/missing.png"
        nil
      else
        true
      end
    end

    add_attribute :icon_img do
      if type_of_offer == "sell"
        '<img src="../assets/sell.png" width="32" />'
      else
        '<img src="../assets/' + nature + '.png" width="32" />'
      end
    end
  end

  def one_price
    output = nil
    if type_of_offer == "service"
      if hourly_price
        output = "#{hourly_price}€/heure"
      end
    elsif type_of_offer == "rent"
      if weekly_price
        output = "#{weekly_price}€/semaine"
      end
      if daily_price
        output = "#{daily_price}€/jour"
      end
    else
      if price
        output = "#{price}€"
      end
    end
    output
  end

  def one_price_int
    output = nil
    if type_of_offer == "service"
      if hourly_price
        output = hourly_price
      end
    elsif type_of_offer == "rent"
      if weekly_price
        output = weekly_price
      end
      if daily_price
        output = daily_price
      end
    else
      if price
        output = price
      end
    end
    output
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

  def cto_reviews
    bookings.map { |booking| booking.reviews.select { |review| review.review_type == "cto" } }.flatten.sort_by { |review| review.created_at }.reverse
  end

  def average_score
    score = 0
    cto_reviews.each do |review|
      score += review.cto_score
    end
    score.fdiv(cto_reviews.size)
  end

  def communication_score
    score = 0
    cto_reviews.each do |review|
      score += review.communication_rating
    end
    score.fdiv(cto_reviews.size)
  end

  def punctuality_score
    score = 0
    cto_reviews.each do |review|
      score += review.punctuality_rating
    end
    score = score.fdiv(cto_reviews.size)
  end

  def quality_price_score
    score = 0
    cto_reviews.each do |review|
      score += review.quality_price_rating
    end
    score = score.fdiv(cto_reviews.size)
  end

  def otc_reviews
    bookings.map { |booking| booking.reviews.select { |review| review.review_type == "otc" } }.flatten
  end

end
