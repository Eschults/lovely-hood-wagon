class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    record.user == user || record.offer.user == user  # Only offer creator or booking creator can view a booking
  end

  def create?
    true  # Anyone can create a booking
  end

  def update?
    record.offer.user == user  # Only offer creator can update (accept/ decline) the booking
  end

  # def destroy?
  #   record.user == user  # Only restaurant creator can update it
  # end
end