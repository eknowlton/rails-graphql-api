require 'rails_helper'

describe 'Set Abilities for User Mutation API', :graphql do
  describe 'setAbilitiesForUser' do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: SetAbilitiesForUserInput!) {
          setAbilitiesForUser(input: $input) {
            user {
              abilities
            }
          }
        }
      GRAPHQL
    end

    it 'gives an ability to a user' do
      user = create(:user)
      acting_user = build(:user, abilities: [:manage_users])
      first_ability, second_ability = Abilities.take(2).map do |ability|
        ability.to_s.upcase
      end

      result = execute query, as: acting_user, variables: {
        input: {
          id: user.id,
          abilities: [first_ability, second_ability]
        }
      }

      user_abilities = result[:data][:setAbilitiesForUser][:user][:abilities]
      expect(user_abilities).to include(first_ability, second_ability)
      expect(user.abilities).to include(
        first_ability.to_sym.downcase,
        second_ability.to_sym.downcase
      )
    end
  end
end
