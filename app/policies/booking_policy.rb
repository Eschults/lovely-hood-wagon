class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user.authorized && (record.user == user || record.offer.user == user)  # Only booking creator can view a booking
  end

  def create?
    user.authorized && user.neighbors.include?(record.offer.user)  # You can create a booking if the offer is one of your neighbors'
  end

  # def confirm?
  #   user.authorized && record.offer.user == user || record.user == user
  # end

  def buy?
    record.user == user
  end

  def cancel?
    record.offer.user == user || record.user == user
  end

  def update?
    user.authorized && record.offer.user == user  # Only offer creator can update (accept/ decline) the booking
  end

  # def destroy?
  #   record.user == user  # Only restaurant creator can update it
  # end
end