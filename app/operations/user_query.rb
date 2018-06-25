class UserQuery < Types::BaseResolver
  description 'The user for the specified id'
  argument :id, ID, required: true
  type Outputs::UserType, null: true
  policy ApplicationPolicy, :logged_in?

  def resolve
    User.find(input.id)
  end
end
