class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [ :facebook ]
  geocoded_by :address
  after_validation :geocode

  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }
  has_attached_file :identity_proof, styles: { large: "600x600>", medium: "300x300>" }
  has_attached_file :address_proof, styles: { large: "600x600>", medium: "300x300>" }

  has_many :offers
  has_many :bookings
  has_many :messages, foreign_key: :writer_id

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

  def mailboxer_email(object)
    #Check if an email should be sent for that object
    #if true
    email
    #if false
    #return nil
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
end
