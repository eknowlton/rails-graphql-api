require 'rails_helper'

describe 'Create Role Mutation API', :graphql do
  describe 'createRole' do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: CreateRoleInput!) {
          createRole(input: $input) {
            role {
              name
            }
          }
        }
      GRAPHQL
    end

    it 'makes a new role' do
      user = build(:user, abilities: [:manage_central])

      result = execute query, as: user, variables: {
        input: {
          roleInput: {
            name: 'test role'
          }
        }
      }

      expect(Role.count).to eq(1)
      name = result[:data][:createRole][:role][:name]
      expect(name).to eq('test role')
    end
  end
end
