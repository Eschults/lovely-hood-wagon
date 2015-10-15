class OfferPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user.admin? || record.user == user || record.user.neighbors.include?(user) # Only offer creator, neighbors and admins can view an offer
  end

  def mine?
    true  # Anyone can view his own offers
  end

  def create?
    true  # Anyone can create an offer
  end

  def update?
    user.admin? || record.user == user  # Only offer creator can update it
  end

  def publish?
    user.admin? || record.user == user  # Only offer creator can publish it
  end

  def hide?
    user.admin? || record.user == user  # Only offer creator can hide it
  end

  def wish?
    user.admin? || record.user == user || record.user.neighbors.include?(user) # Only offer creator, neighbors and admins can view an offer
  end

  def unwish?
    user.admin? || record.user == user || record.user.neighbors.include?(user) # Only offer creator, neighbors and admins can view an offer
  end

  def map?
    user.admin?
  end


  # def destroy?
  #   record.user == user  # Only offer creator can destroy it
  # end
end