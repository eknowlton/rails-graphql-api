class CreateRoleMutation < Types::BaseMutation
  description 'Creates a new role'

  argument :role_input, Inputs::Role, required: true

  field :role, Outputs::RoleType, null: true
  field :errors, function: Resolvers::Error.new, null: false

  policy RolePolicy, :manage?

  def authorized_resolve
    role = Role.new(role_args)

    if role.save
      { role: role, errors: [] }
    else
      { role: nil, errors: role.errors }
    end
  end

  private

  def role_args
    input.role_input.to_h
  end
end
