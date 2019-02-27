class SuspendUserMutation < Types::BaseMutation
  description "Suspend a user"

  argument :id, ID, required: true

  field :user, Outputs::UserType, null: true
  field :errors, function: Resolvers::Error.new, null: false

  policy UserPolicy, :manage?

  def authorized_resolve
    user = User.find(input.id)

    if user.suspend
      {user: user, errors: []}
    else
      {user: nil, errors: user.errors}
    end
  end
end
