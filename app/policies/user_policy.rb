class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user.authorized || user == record
  end

  def create?
    true
  end

  def update?
    record == user
  end
end