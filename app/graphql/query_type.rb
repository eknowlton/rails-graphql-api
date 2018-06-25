class QueryType < Types::BaseObject
  field :roles, resolver: RolesQuery
  field :role, resolver: RoleQuery
end
