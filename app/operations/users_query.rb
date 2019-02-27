class UsersQuery < Types::BaseResolver
  description "Get all users"
  type [Outputs::UserType], null: false
  policy ApplicationPolicy, :logged_in?

  def authorized_resolve
    User.all
  end
end
