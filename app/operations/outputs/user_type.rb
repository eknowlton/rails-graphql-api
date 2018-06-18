module Outputs
  class UserType < Types::BaseObject
    implements Types::ActiveRecord

    field :email, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
  end
end
