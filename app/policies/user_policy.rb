class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all.reject { |u| u.id == user.id }.sort_by(&:updated_at).reverse
      elsif user.latitude.nil?
        scope.all.reject { |u| u.id }
      else
        scope.all.reject { |u1| u1.latitude.nil? || u1.id == user.id }.select { |u| user.is_distant_in_km_from(u) <= 1.1 }.sort_by(&:updated_at).reverse
      end
    end
  end

  def show?
    true
  end

  def create?
    true
  end

  def map?
    user.admin?
  end

  def update?
    user.admin? || user == record
  end
end