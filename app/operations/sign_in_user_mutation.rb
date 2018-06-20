class SignInUserMutation < Types::BaseMutation
  description 'Sign the user in'

  argument :email, String, required: true
  argument :password, String, required: true

  field :user, Outputs::UserType, null: true
  field :token, Outputs::TokenType, null: true
  field :errors, function: Resolvers::Error.new

  def resolve
    result = CredentialAuthentication.new(email: input.email, password: input.password).authenticate

    if result.success?
      { user: result.user, token: result.token, errors: [] }
    else
      { user: nil, token: nil, errors: result.errors }
    end
  end
end
