class User < ActiveRecord::Base
  after_create :send_welcome_email

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [ :facebook ]

  acts_as_voter

  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }
  has_attached_file :identity_proof, styles: { large: "600x600>", medium: "300x300>" }
  has_attached_file :address_proof, styles: { large: "600x600>", medium: "300x300>" }

  has_many :offers
  has_many :bookings
  has_many :messages, foreign_key: :writer_id

  def address_changed?
    :street_number_changed? || :zipcode_changed?
  end

  def conversations
    Conversation.where("user1_id = :id OR user2_id = :id", id: self.id)
  end

  def conversation_with(recipient)
    if Conversation.where("(user1_id = :my_id AND user2_id = :her_id) OR (user1_id = :her_id AND user2_id = :my_id)", my_id: self.id, her_id: recipient.id).first
      Conversation.where("(user1_id = :my_id AND user2_id = :her_id) OR (user1_id = :her_id AND user2_id = :my_id)", my_id: self.id, her_id: recipient.id).first
    else
      nil
    end
  end

  # def conversations=

  # end

  validates_presence_of :email
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  validates_attachment_content_type :identity_proof, content_type: /\Aimage\/.*\z/
  validates_attachment_content_type :address_proof, content_type: /\Aimage\/.*\z/

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.picture = URI.parse(auth.info.image.gsub("­http","htt­ps"))
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end

  def address
    "#{self.street_number} #{self.street_name}, #{self.zip_code} #{self.city}"
  end

  def name
    "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end

  def unread_conversations
    output = 0
    conversations.each do |conversation|
      if conversation.messages.select{ |message| message.writer != self }.map{ |message| message.read_at }.include? nil
        output += 1
      end
    end
    output
  end

  def verif
    output = 0
    unless identity_verified
      output += 1
    end
    unless address_verified
      output += 1
    end
    return output
  end

  def ongoing_bookings
    client_bookings = []
    bookings.each do |booking|
      if booking.end_date > Date.today && booking.start_date <= Date.today && booking.accepted
        client_bookings << booking
      end
    end
    owner_bookings = []
    offers.each do |offer|
      offer.bookings.each do |booking|
        if booking.end_date > Date.today && booking.start_date <= Date.today && booking.accepted && booking.owner_validation.nil?
          owner_bookings << booking
        end
      end
    end
    {
      owner: owner_bookings,
      client: client_bookings
    }

  end

  def passed_bookings_to_validate
    client_bookings = []
    bookings.each do |booking|
      if booking.end_date <= Date.today && booking.accepted && (booking.client_validation.nil? || booking.owner_validation.nil?)
        client_bookings << booking
      end
    end
    owner_bookings = []
    offers.each do |offer|
      offer.bookings.each do |booking|
        if booking.end_date <= Date.today && booking.accepted && booking.owner_validation.nil?
          owner_bookings << booking
        end
      end
    end
    {
      owner: owner_bookings,
      client: client_bookings
    }
  end

  def upcoming_bookings
    client_bookings = []
    bookings.each do |booking|
      if ((booking.start_date > Date.today) && (booking.accepted.nil? || booking.accepted)) || (booking.start_date == Date.today && booking.accepted.nil?)
        client_bookings << booking
      end
    end
    owner_bookings = []
    offers.each do |offer|
      offer.bookings.each do |booking|
        if ((booking.start_date > Date.today) && (booking.accepted.nil? || booking.accepted)) || (booking.start_date == Date.today && booking.accepted.nil?)
          owner_bookings << booking
        end
      end
    end
    {
      client: client_bookings,
      owner: owner_bookings
    }
  end

  def upcoming_otc_bookings
  end

  def upcoming_pending_cto_bookings
    output = []
    bookings.each do |booking|
      if booking.start_date >= Date.today && booking.accepted.nil?
        output << booking
      end
    end
    output
  end

  def cto_reviews
    output = []
    offers.each do |offer|
      offer.bookings.each do |booking|
        booking.reviews.each do |review|
          if review.review_type == "cto"
            output << review
          end
        end
      end
    end
    output
  end

  def otc_reviews
    output = []
    bookings.each do |booking|
      booking.reviews.each do |review|
        if review.review_type == "otc"
          output << review
        end
      end
    end
    output
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver
  end
end
