class DeleteRoleMutation < Types::BaseMutation
  description "Delete the specified role"

  argument :id, ID, required: true

  field :success, Boolean, null: false
  field :errors, function: Resolvers::Error.new, null: false

  policy RolePolicy, :manage?

  def authorized_resolve
    role = Role.find(input.id).destroy

    {success: role.deleted?, errors: role.errors}
  end
end
