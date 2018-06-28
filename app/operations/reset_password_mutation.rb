class ResetPasswordMutation < Types::BaseMutation
  description 'Resets the users password and returns a valid auth token'

  argument :password, String, required: true
  argument :reset_password_token, String, required: true

  field :user, Outputs::UserType, null: true
  field :access_token, Outputs::TokenType, null: true
  field :refresh_token, Outputs::TokenType, null: true
  field :errors, function: Resolvers::Error.new, null: false

  def resolve
    result = ResetPassword.new(reset_password_args).call

    if result.success?
      { user: result.user,
        access_token: result.access_token,
        refresh_token: result.refresh_token,
        errors: [] }
    else
      { user: nil, token: nil, errors: result.errors }
    end
  end

  private

  def reset_password_args
    { token_body: input.reset_password_token, password: input.password }
  end
end
