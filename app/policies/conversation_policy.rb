class ConversationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    user.admin || (user.authorized && record.user1 != record.user2 && record.user1.neighbors.include?(record.user2)) || record.user1.admin || record.user2.admin
  end

  def new_b?
    user.admin || (user.authorized && record.user1 != record.user2 && record.user1.neighbors.include?(record.user2)) || record.user1.admin || record.user2.admin
  end

  def create_b?
    user.admin || (user.authorized && record.user1 != record.user2 && record.user1.neighbors.include?(record.user2)) || record.user1.admin || record.user2.admin
  end

  def new_u?
    user.admin || (record.user1 != record.user2 && record.user1.neighbors.include?(record.user2)) || record.user1.admin || record.user2.admin
  end

  def create_u?
    user.admin || (record.user1 != record.user2 && record.user1.neighbors.include?(record.user2)) || record.user1.admin || record.user2.admin
  end

  def reply?
    (record.user1 == user || record.user2 == user)
  end

  def reply_server?
    (record.user1 == user || record.user2 == user)
  end

  def index?
    user.admin
  end

  def show?
    (record.user1 == user || record.user2 == user)
  end
end