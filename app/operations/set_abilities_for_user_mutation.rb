class SetAbilitiesForUserMutation < Types::BaseMutation
  description "Syncs the abilities of the specified user to those provided"

  argument :id, ID, required: true
  argument :abilities, [Types::AbilityType], required: true

  field :user, Outputs::UserType, null: true
  field :errors, function: Resolvers::Error.new, null: false

  policy UserPolicy, :manage?

  def authorized_resolve
    user = User.find(input.id)
    result = SyncAbilities.new(user, input.abilities).call

    if result.success?
      {user: user, errors: []}
    else
      {user: nil, errors: user.errors}
    end
  end
end
