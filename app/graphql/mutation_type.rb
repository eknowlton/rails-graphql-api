class MutationType < Types::BaseObject
  field :sign_in_user, mutation: SignInUserMutation
  field :create_user, mutation: CreateUserMutation
end
