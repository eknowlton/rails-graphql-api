require 'rails_helper'

describe 'Role Query API', :graphql do
  describe 'role' do
    let(:query) do
      <<~'GRAPHQL'
        query($id: ID!) {
          role(id: $id) {
            name
          }
        }
      GRAPHQL
    end

    it 'gets the role with the specified id' do
      role = create(:role)

      result = execute query, as: build(:user), variables: { id: role.id }

      name = result[:data][:role][:name]
      expect(name).to eq(role.name)
    end
  end

  describe 'role abilities' do
    let(:query) do
      <<~'GRAPHQL'
        query($id: ID!) {
          role(id: $id) {
            name
            abilities
          }
        }
      GRAPHQL
    end

    it 'gets the specified role with abilities' do
      ability = Abilities.first
      role = create(:role)
      role.permissions.create(ability: ability)

      result = execute query, as: build(:user), variables: { id: role.id }

      abilities = result[:data][:role][:abilities]
      expect(abilities).to include(ability.to_s.upcase)
    end
  end
end
