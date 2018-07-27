module Outputs
  class UserType < Types::BaseObject
    implements Types::ActiveRecord

    field :email, String, null: false
    field :first_name, String, null: false
    field :last_name, String, null: false
    field :nickname, String, null: true
    field :abbreviation, String, null: false
    field :title, String, null: false
    field :linkedin_url, String, null: true
    field :birth_date, Types::DateType, null: true
    field :hire_date, Types::DateType, null: false
    field :active, Boolean, null: false
    field :admin, Boolean, null: false
    field :abilities,
          [Types::AbilityType],
          null: true,
          description: <<~DESC
            A list of abilities the user has. Includes the users own abilities
            and any abilties gained from their role.
          DESC
    field :own_abilities,
          [Types::AbilityType],
          null: true,
          description: 'A list of abilities that are assigned directly to the user.'
    field :role_abilities,
          [Types::AbilityType],
          null: true,
          description: 'A list of abilities granted to the user by their role.'

    def admin
      @object.admin?
    end

    def own_abilities
      @object.permissions.map(&:ability)
    end

    def role_abilities
      @object.role_permissions.map(&:ability)
    end
  end
end
