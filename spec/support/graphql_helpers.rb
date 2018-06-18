module GraphQLHelpers
  def execute(query, context: {}, variables: {})
    CentralSchema.execute(
      query,
      context: context,
      variables: variables.with_indifferent_access
    ).with_indifferent_access
  end
end
