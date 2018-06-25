class QueryType < Types::BaseObject
  field :users, resolver: UsersQuery
  field :user, resolver: UserQuery
  field :roles, resolver: RolesQuery
  field :role, resolver: RoleQuery
end
