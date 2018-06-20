class UpdateRoleMutation < Types::BaseMutation
  description 'Update the specified role'

  argument :id, ID, required: true
  argument :role_input, Inputs::PatchRole, required: true

  field :role, Outputs::RoleType, null: true
  field :errors, function: Resolvers::Error.new, null: false

  policy RolePolicy, :manage?

  def authorized_resolve
    role = Role.find(input.id)

    if role.update(role_args)
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
