class RoleQuery < Types::BaseResolver
  description 'The role for the specified id'
  argument :id, ID, required: true
  type Outputs::RoleType, null: true
  policy RolePolicy, :logged_in

  def resolve
    Role.find(input.id)
  end
end
