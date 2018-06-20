module Inputs
  class Role < Types::BaseInputObject
    graphql_name 'RoleInput'
    description 'Properties for a Role'
    argument :name, String, required: true
  end
end
