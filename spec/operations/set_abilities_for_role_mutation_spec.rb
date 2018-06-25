require 'rails_helper'

describe 'Set Abilities for Role Mutation API', :graphql do
  describe 'setAbilitiesForRole' do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: SetAbilitiesForRoleInput!) {
          setAbilitiesForRole(input: $input) {
            role {
              abilities
            }
          }
        }
      GRAPHQL
    end

    it 'assigns abilities to a role' do
      acting_user = build(:user, abilities: [:manage_roles])
      role = create(:role)
      first_ability, second_ability = Abilities.take(2).map do |ability|
        ability.to_s.upcase
      end

      result = execute query, as: acting_user, variables: {
        input: {
          id: role.id,
          abilities: [first_ability, second_ability]
        }
      }

      role_abilities = result[:data][:setAbilitiesForRole][:role][:abilities]
      expect(role_abilities).to include(first_ability, second_ability)
      expect(role.abilities).to include(
        first_ability.to_sym.downcase,
        second_ability.to_sym.downcase
      )
    end
  end
end
