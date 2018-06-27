class ResetPasswordMutation < Types::BaseMutation
  description 'Resets the users password and returns a valid auth token'

  argument :password, String, required: true
  argument :reset_password_token, String, required: true

  field :user, Outputs::UserType, null: true
  field :token, Outputs::TokenType, null: true, description: 'A valid auth token for the user'
  field :errors, function: Resolvers::Error.new, null: false

  def resolve
    result = ResetPassword.new(
      token_body: input.reset_password_token,
      password: input.password
    ).call

    if result.success?
      { user: result.user, token: result.auth_token, errors: [] }
    else
      { user: nil, token: nil, errors: result.errors }
    end
  end
end
