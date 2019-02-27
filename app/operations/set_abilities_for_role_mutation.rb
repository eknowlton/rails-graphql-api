class SetAbilitiesForRoleMutation < Types::BaseMutation
  description "Syncs the abilities of the specified role to those provided"

  argument :id, ID, required: true
  argument :abilities, [Types::AbilityType], required: true

  field :role, Outputs::RoleType, null: true
  field :errors, function: Resolvers::Error.new, null: false

  policy RolePolicy, :manage?

  def authorized_resolve
    role = Role.find(input.id)
    result = SyncAbilities.new(role, input.abilities).call

    if result.success?
      {role: role, errors: []}
    else
      {role: nil, errors: role.errors}
    end
  end
end
