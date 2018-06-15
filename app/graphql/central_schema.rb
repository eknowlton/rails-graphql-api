class CentralSchema < GraphQL::Schema
  mutation(MutationType)
  query(QueryType)
end
