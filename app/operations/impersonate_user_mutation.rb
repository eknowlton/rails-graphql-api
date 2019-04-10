class ImpersonateUserMutation < Types::BaseMutation
  description "Provides refresh and access tokens for the specified user"

  argument :email, String, required: true

  field :user, Outputs::UserType, null: true
  field :access_token, String, null: true
  field :refresh_token, String, null: true

  policy UserPolicy, :manage?

  def authorized_resolve
    user = User.find_by!(email: input.email)

    {
      user: user,
      access_token: AccessToken.issue(user),
      refresh_token: RefreshToken.issue(user),
    }
  end
end
