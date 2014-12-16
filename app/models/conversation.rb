class Conversation < ActiveRecord::Base
  belongs_to :user1, class_name: "User"
  belongs_to :user2, class_name: "User"

  has_many :messages
  accepts_nested_attributes_for :messages
  validates_presence_of :user1, :user2
end
