class OfferPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true  # Anyone can view an offer
  end

  def create?
    true  # Anyone can create an offer
  end

  def update?
    record.user == user  # Only offer creator can update it
  end

  # def destroy?
  #   record.user == user  # Only offer creator can destroy it
  # end
end