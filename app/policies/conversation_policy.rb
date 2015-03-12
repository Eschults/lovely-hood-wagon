class ConversationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.authorized && record.user1 != record.user2
  end

  def new_b?
    user.authorized && record.user1 != record.user2
  end

  def create_b?
    user.authorized && record.user1 != record.user2
  end

  def new_u?
    user.authorized && record.user1 != record.user2
  end

  def create_u?
    user.authorized && record.user1 != record.user2
  end

  def reply?
    user.authorized && (record.user1 == user || record.user2 == user)
  end

  def reply_server?
    user.authorized && (record.user1 == user || record.user2 == user)
  end

  def index?
    user.authorized && true
  end

  def show?
    user.authorized && (record.user1 == user || record.user2 == user)
  end
end