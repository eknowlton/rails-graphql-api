class CentralSchema < GraphQL::Schema
  use GraphQL::Tracing::SkylightTracing, set_endpoint_name: true

  mutation(MutationType)
  query(QueryType)
end
