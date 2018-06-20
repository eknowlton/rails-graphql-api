module Inputs
  class PatchRole < Types::BaseInputObject
    graphql_name 'PatchRoleInput'
    description 'The properties of a role that can be updated'
    argument :name, String, required: false
  end
end
