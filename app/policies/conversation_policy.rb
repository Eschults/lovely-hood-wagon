class ConversationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def reply?
    true
  end

  def index?
    true
  end

  def show?
    true
  end
end