class RolePolicy < ApplicationPolicy
  def manage?
    user.can?(:manage_central)
  end
end
