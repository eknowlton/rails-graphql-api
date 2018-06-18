class CreateUserMutation < Types::BaseMutation
  description 'Creates a new user'

  argument :user_input, Inputs::User, required: true

  field :user, Outputs::UserType, null: true
  field :errors, function: Resolvers::Error.new, null: false

  def resolve
    result = CreateUser.new(user_args).call

    if result.success?
      { user: result.user, errors: [] }
    else
      { user: nil, errors: result.errors }
    end
  end

  private

  def user_args
    input.user_input.to_h
  end
end
