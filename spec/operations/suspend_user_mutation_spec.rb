require 'rails_helper'

describe 'Suspend User Mutation API', :graphql do
  describe 'suspendUser' do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: SuspendUserInput!) {
          suspendUser(input: $input) {
            user {
              active
            }
          }
        }
      GRAPHQL
    end

    it 'suspends a user' do
      acting_user = build(:user, abilities: [:manage_users])
      user = create(:user, active: true)

      execute query, as: acting_user, variables: {
        input: {
          id: user.id
        }
      }

      expect(user.reload.active).to be(false)
    end
  end
end
