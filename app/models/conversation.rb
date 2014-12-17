class Conversation < ActiveRecord::Base
  belongs_to :user1, class_name: "User"
  belongs_to :user2, class_name: "User"

  has_many :messages
  accepts_nested_attributes_for :messages
  validates_presence_of :user1, :user2

  def other_user(current_user)
    if user1 == current_user
      user2
    elsif user2 == current_user
      user1
    else
      nil
    end
  end

  def unread_messages(current_user)
    messages.select{ |message| message.writer != current_user }.select { |message| message.read_at == nil }.size
  end
end
