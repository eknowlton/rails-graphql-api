module Inputs
  class PatchUser < Types::BaseInputObject
    graphql_name "PatchUserInput"
    description "The properties of a user that can be updated"
    argument :walter_id, Int, required: false
    argument :first_name, String, required: false
    argument :last_name, String, required: false
    argument :nickname, String, required: false
    argument :abbreviation, String, required: false
    argument :title, String, required: false
    argument :linkedin_url, String, required: false
    argument :birth_date, Types::DateType, required: false
    argument :hire_date, Types::DateType, required: false
  end
end
