module Inputs
  class User < Types::BaseInputObject
    graphql_name 'UserInput'
    description 'Properties for a User'
    argument :email, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true
  end
end
