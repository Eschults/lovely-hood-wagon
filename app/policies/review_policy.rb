class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user.authorized
  end

  def create?
    user.authorized && (record.booking.offer.user == user || record.booking.user == user  # Anyone can create a booking)
  end

  def update?
    user.authorized && (record.booking.offer.user == user || record.booking.user == user  # Anyone can create a booking)
  end
end