class UpdateUserMutation < Types::BaseMutation
  description 'Update the specified user'

  argument :id, ID, required: true
  argument :user_input, Inputs::PatchUser, required: true

  field :user, Outputs::UserType, null: true
  field :errors, function: Resolvers::Error.new, null: false

  policy UserPolicy, :manage?

  def authorized_resolve
    user = User.find(input.id)
    result = UpdateUser.new(user: user, params: user_input).call

    if result.success?
      { user: result.user, errors: [] }
    else
      { user: nil, errors: result.errors }
    end
  end

  private

  def user_input
    input.user_input.to_h
  end
end
