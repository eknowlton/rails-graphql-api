class RolePolicy < ApplicationPolicy
  def manage?
    !user.guest?
  end
end
