class MutationType < Types::BaseObject
  field :sign_in_user, mutation: SignInUserMutation
  field :create_user, mutation: CreateUserMutation
  field :create_role, mutation: CreateRoleMutation
  field :update_role, mutation: UpdateRoleMutation
  field :delete_role, mutation: DeleteRoleMutation
end
