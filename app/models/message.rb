class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :writer, class_name: "User"

  validates_presence_of :conversation, :writer, :content
end
