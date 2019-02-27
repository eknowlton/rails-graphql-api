class InvalidateUserTokensMutation < Types::BaseMutation
  description "Invalidates all issued refresh tokens for the specified user"

  argument :id, ID, required: true

  field :user, Outputs::UserType, null: true
  field :errors, function: Resolvers::Error.new, null: false

  policy UserPolicy, :manage?

  def authorized_resolve
    user = User.find(input.id)

    if user.invalidate_tokens
      {user: user, errors: []}
    else
      {user: nil, errors: user.errors}
    end
  end
end
