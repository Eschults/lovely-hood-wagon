class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all.reject { |u| u.id == user.id }
      else
        scope.all.reject { |u1| u1.latitude.nil? || u1.id == user.id }.select { |u| user.is_distant_in_km_from(u) <= 1 }
      end
    end
  end

  def show?
    user.neighbors.include?(record) || user == record || user.admin?
  end

  def create?
    true
  end

  def update?
    user.admin? || user == record
  end
end