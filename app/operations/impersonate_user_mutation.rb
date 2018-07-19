class ImpersonateUserMutation < Types::BaseMutation
  description 'Provides refresh and access tokens for the specified user'

  argument :user_id, ID, required: true

  field :user, Outputs::UserType, null: true
  field :access_token, String, null: true
  field :refresh_token, String, null: true

  policy UserPolicy, :manage?

  def authorized_resolve
    user = User.find(input.user_id)

    {
      user: user,
      access_token: AccessToken.issue(user),
      refresh_token: RefreshToken.issue(user)
    }
  end
end
