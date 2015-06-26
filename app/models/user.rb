module PublicActivity
  class Activity < inherit_orm("Activity")
    acts_as_votable
    has_many :activity_comments
  end
end
class User < ActiveRecord::Base
  include PublicActivity::Common
  after_create :send_welcome_email, :send_welcome_message

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [ :facebook ]

  acts_as_voter

  geocoded_by :address
  after_validation :geocode, if: :address_changed?
  # after_update :unvalidate_address, if: :address_changed?

  has_attached_file :picture,
    styles: { medium: "300x300#", thumb: "100x100#" }
  has_attached_file :identity_proof, styles: { large: "600x600>", medium: "300x300>" }
  has_attached_file :address_proof, styles: { large: "600x600>", medium: "300x300>" }

  has_many :offers
  has_many :bookings
  has_many :messages, foreign_key: :writer_id
  has_many :posts
  has_many :comments

  def age
    d = Date.today
    (d.year - birthday.year) - (d.month == birthday.month ? (d.day >= birthday.day ? 0 : 1) : (d.month > birthday.month ? 0 : 1))
  end

  def address_changed?
    self.street_changed?
  end

  def unvalidate_address
    address_verified = false
    offers.each do |offer|
      offer.published = false
      offer.save
    end
  end

  def published_offers
    offers.select { |offer| offer.published }
  end

  def unpublished_offers
    offers - published_offers
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

  def neighbors_posts
    @posts = []
    neighbors.each do |neighbor|
      neighbor.posts.each do |post|
        @posts << post
      end
    end
    User.find_by_first_name("Lovely Hood").posts.each do |post|
      @posts << post
    end
    @posts
  end

  def posts_in_scope
    if admin?
      Post.all
    else
      neighbors_posts + posts
    end
  end

  def is_distant_in_km_from(user)
    r = 6371
    d_lat = (user.latitude - latitude) * (Math::PI / 180)
    d_lon = (user.longitude - longitude) * (Math::PI / 180)
    a = Math::sin(d_lat/2) * Math::sin(d_lat/2) + Math::cos(latitude * (Math::PI / 180)) * Math::cos(user.latitude * (Math::PI / 180)) * Math::sin(d_lon/2) * Math::sin(d_lon/2)
    distance = r * 2 * Math::atan2(Math::sqrt(a), Math.sqrt(1-a))
  end

  def is_neighbors_with?(user)
    neighbors.include? user
  end

  def neighbors
    User.all.reject { |u1| u1.latitude.nil? }.select { |u| is_distant_in_km_from(u) <= 1.1 }.reject { |moi| moi == self }
  end

  def neighbors_and_lh
    neighbors << User.find_by_first_name("Lovely Hood")
  end

  def neighbors_lh_and_self
    neighbors_and_lh << self
  end

  def common_neighbors(neighbor)
    neighbors.select { |user| user if neighbor.neighbors.include?(user) && user != neighbor }
  end

  def exclusive_neighbors(neighbor)
    neighbors - common_neighbors(neighbor) - [neighbor]
  end

  validates_presence_of :email
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/
  validates_attachment_content_type :identity_proof, content_type: [/\Aimage\/.*\z/, "application/pdf"]
  validates_attachment_content_type :address_proof, content_type: ["application/pdf", /\Aimage\/.*\z/]

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.first_name = auth.info.first_name
      user.last_name = auth.info.last_name
      user.picture = URI.parse(auth.info.image.gsub("­http","htt­ps").gsub('small', 'large'))
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end

  def address
    "#{street}, #{zip_code} #{city}"
  end

  def name
    "#{first_name.nil? ? "" : first_name.capitalize + " "}#{last_name.nil? ? "" : last_name.capitalize}"
  end

  def ready_to_receive_money?
    if bic.nil? || iban.nil?
      false
    else
      true
    end
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
    unless ready_to_receive_money?
      output += 1
    end
    return output
  end

  def trust_steps
    output = 0
    unless identity_verified
      output += 1
    end
    unless address_verified
      output += 1
    end
    output
  end

  def money_step
    output = 0
    if iban.nil?
      output += 1
    end
    if bic.nil?
      output += 1
    end
    output
  end

  def ongoing_bookings
    client_bookings = []
    bookings.each do |booking|
      if booking.offer.type_of_offer == "sell"
        if booking.start_date == Date.today && booking.accepted
          client_bookings << booking
        end
      else
        if booking.end_date > Date.today && booking.start_date <= Date.today && booking.accepted
          client_bookings << booking
        end
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

  def passed_bookings_to_review
    client_bookings = []
    bookings.each do |booking|
      if booking.offer.type_of_offer == "sell"
        if booking.start_date <= Date.today && booking.accepted && booking.has_to_be_reviewed_by_client?
          client_bookings << booking
        end
      else
        if booking.end_date <= Date.today && booking.accepted && booking.has_to_be_reviewed_by_client?
          client_bookings << booking
        end
      end
    end
    owner_bookings = []
    offers.each do |offer|
      offer.bookings.each do |booking|
        if booking.end_date <= Date.today && booking.accepted && booking.has_to_be_reviewed_by_owner?
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

  def avge_cto_reco_percent
    sum = 0
    count = 0
    cto_reviews.each do |cto_review|
      sum += 1 if cto_review.recommendation
      count += 1
    end
    sum.fdiv(count) * 100
  end

  def avge_otc_reco_percent
    sum = 0
    count = 0
    otc_reviews.each do |otc_review|
      sum += 1 if otc_review.recommendation
      count += 1
    end
    sum.fdiv(count) * 100
  end

  def avge_cto_rating
    sum = 0
    count = 0
    cto_reviews.each do |cto_review|
      sum += cto_review.cto_score
      count += 1
    end
    sum.fdiv(count)
  end

  def avge_otc_rating
    sum = 0
    count = 0
    otc_reviews.each do |otc_review|
      sum += otc_review.otc_score
      count += 1
    end
    sum.fdiv(count)
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

  def stripe_customer
    @stripe_customer ||= (
      ensure_stripe_customer!
      Stripe::Customer.retrieve(stripe_customer_token)
    )
  end

  def ensure_stripe_customer!
    return if stripe_customer_token.present?

    @stripe_customer = Stripe::Customer.create(
      :email => email,
      :description => name,
    )
    self.stripe_customer_token = @stripe_customer.id
    self.save
  end

  def create_card(stripe_token)
    card = stripe_customer.sources.create(card: stripe_token)

    card.name = name
    card.address_line1 = street if !street.blank?
    card.address_city = city if !city.blank?
    card.address_zip = zip_code if !zip_code.blank?
    card.address_country = "France"
    card.save
    card
  end

  def self.all_emails_in_array
    output = []
    all.each do |user|
      output << user.email
    end
    output
  end

  def self.all_emails_in_string
    all_emails_in_array.join(", ")
  end

  private

  def send_welcome_email
    UserMailer.welcome(self).deliver
  end

  def send_welcome_message
    lh = User.find_by_first_name("Lovely Hood")
    @conversation = Conversation.new
    @conversation.user1 = lh
    @conversation.user2 = self
    @message = Message.new(
      content: "Bienvenue sur Lovely Hood !

      Avant tout, complétez votre <a href='/users/#{self.id}/edit'>profil</a>.

      Ensuite, pour améliorer l'activité de votre quartier sur le site, nous vous invitons à ouvrir <a href='https://www.lovely-hood.com/early_birds_poster' target='_blank'>cette page</a> et à l'imprimer en quelques exemplaires.

      Affichez ce petit mot dans les zones de passage de votre voisinage (le hall de votre immeuble, votre boulangerie, votre pharmacie, votre supermarché, votre bar ou restaurant préféré, etc...).

      Cela vous permettra de multiplier les chances de trouver ce que vous cherchez lors de vos prochaines visites sur le site ! :)

      Si vous avez une question, écrivez-moi en répondant à ce message !

      With love,

      L'équipe LH
      "
    )
    @message.writer = lh
    @message.conversation = @conversation
    @message.save
  end
end
