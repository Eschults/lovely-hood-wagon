class ConversationPolicy < Struct.new(:user, :conversation)
  def create?
    true
  end

  def reply?
    true
  end

  def trash?
    true
  end

  def untrash?
    true
  end
end