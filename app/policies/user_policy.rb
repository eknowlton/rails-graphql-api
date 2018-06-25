class UserPolicy < ApplicationPolicy
  def manage?
    user.can?(:manage_users)
  end
end
