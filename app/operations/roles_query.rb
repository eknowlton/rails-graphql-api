class RolesQuery < Types::BaseResolver
  description "Get all roles"
  type [Outputs::RoleType], null: false
  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    Role.all
  end
end
