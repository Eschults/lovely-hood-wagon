class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [ :facebook ]
  geocoded_by :address
  after_validation :geocode
  acts_as_messageable

  has_attached_file :picture,
    styles: { medium: "300x300>", thumb: "100x100>" }

  has_many :offers

  validates_presence_of :email
  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.name = auth.info.name
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
end
