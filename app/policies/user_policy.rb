class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.admin?
        scope.all.reject { |u| u.id == user.id }
      else
        scope.where("(latitude - :my_lat) * (latitude - :my_lat) + (longitude - :my_lng) * (longitude - :my_lng) < 0.004 * 0.004 AND id != :my_id", my_lat: user.latitude, my_lng: user.longitude, my_id: user.id)
      end
    end
  end

  def show?
    user.admin || user.neighbors.include?(record) || user == record
  end

  def create?
    true
  end

  def update?
    user.admin || user == record
  end
end