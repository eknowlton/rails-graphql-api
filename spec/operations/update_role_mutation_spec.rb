require 'rails_helper'

describe 'Update Role Mutation API', :graphql do
  describe 'updateRole' do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: UpdateRoleInput!) {
          updateRole(input: $input) {
            role {
              name
            }
          }
        }
      GRAPHQL
    end

    it 'updates the specified role' do
      role = create(:role)
      user = build(:user)

      result = execute query, as: user, variables: {
        input: {
          id: role.id,
          roleInput: {
            name: 'updated role'
          }
        }
      }

      name = result[:data][:updateRole][:role][:name]
      expect(name).to eq('updated role')
      expect(role.reload.name).to eq('updated role')
    end
  end
end
