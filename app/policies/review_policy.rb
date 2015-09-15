class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    (record.booking.offer.user == user || record.booking.user == user)
  end

  def create?
    (record.booking.offer.user == user || record.booking.user == user)
  end

  def update?
    (record.booking.offer.user == user || record.booking.user == user)
  end
end