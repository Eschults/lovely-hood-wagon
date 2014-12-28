class ReviewPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def create?
    record.booking.offer.user == user || record.booking.user == user  # Anyone can create a booking
  end

  def update?
    record.booking.offer.user == user || record.booking.user == user  # Anyone can create a booking
  end
end