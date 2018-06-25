class MutationType < Types::BaseObject
  field :sign_in_user, mutation: SignInUserMutation
  field :create_user, mutation: CreateUserMutation
  field :create_role, mutation: CreateRoleMutation
  field :update_role, mutation: UpdateRoleMutation
  field :delete_role, mutation: DeleteRoleMutation
  field :set_abilities_for_role, mutation: SetAbilitiesForRoleMutation
  field :set_abilities_for_user, mutation: SetAbilitiesForUserMutation
end
