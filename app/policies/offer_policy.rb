class OfferPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user.authorized || user == record.user # Anyone can view an offer
  end

  def mine?
    true  # Anyone can view his own offers
  end

  def create?
    true  # Anyone can create an offer
  end

  def update?
    record.user == user  # Only offer creator can update it
  end

  def wish?
    user.authorized
  end

  def unwish?
    user.authorized
  end


  # def destroy?
  #   record.user == user  # Only offer creator can destroy it
  # end
end