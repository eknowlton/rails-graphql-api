class RolePolicy < ApplicationPolicy
  def manage?
    user.can?(:manage_testmydev)
  end
end
