module Outputs
  class RoleType < Types::BaseObject
    implements Types::ActiveRecord

    field :id, ID, null: false
    field :name, String, null: false
    field :abilities, [Types::AbilityType], null: true
  end
end
