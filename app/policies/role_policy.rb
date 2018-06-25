class RolePolicy < ApplicationPolicy
  def manage?
    user.can?(:manage_roles)
  end
end
