class UserPolicy < ApplicationPolicy
  def manage?
    !user.guest?
  end
end
