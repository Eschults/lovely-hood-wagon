class ConversationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where("")
    end
  end

  def create?
    record.user1 != record.user2
  end

  def reply?
    record.user1 == user || record.user2 == user
  end

  def index?
    true
  end

  def show?
    record.user1 == user || record.user2 == user
  end
end