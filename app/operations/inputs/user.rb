module Inputs
  class User < Types::BaseInputObject
    graphql_name "UserInput"
    description "Properties for a User"
    argument :walter_id, Int, required: false
    argument :email, String, required: true
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :nickname, String, required: false
    argument :abbreviation, String, required: true
    argument :title, String, required: true
    argument :linkedin_url, String, required: false
    argument :birth_date, Types::DateType, required: false
    argument :hire_date, Types::DateType, required: true
  end
end
