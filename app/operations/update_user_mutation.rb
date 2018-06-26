class UpdateUserMutation < Types::BaseMutation
  description 'Update the specified user'

  argument :id, ID, required: true
  argument :user_input, Inputs::PatchUser, required: true

  field :user, Outputs::UserType, null: true
  field :errors, function: Resolvers::Error.new, null: false

  policy UserPolicy, :manage?

  def authorized_resolve
    user = User.find(input.id)

    if user.update(user_args)
      { user: user, errors: [] }
    else
      { user: nil, errors: user.errors }
    end
  end

  private

  def user_args
    input.user_input.to_h
  end
end
