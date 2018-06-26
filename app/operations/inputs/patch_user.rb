module Inputs
  class PatchUser < Types::BaseInputObject
    graphql_name 'PatchUserInput'
    description 'The properties of a user that can be updated'
    argument :first_name, String, required: false
    argument :last_name, String, required: false
  end
end
