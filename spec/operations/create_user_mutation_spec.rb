require 'rails_helper'

describe 'Create User Mutation API', :graphql do
  describe 'createUser' do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: CreateUserInput!) {
          createUser(input: $input) {
            user {
              id
            }
          }
        }
      GRAPHQL
    end

    it 'makes a new user' do
      user = build(:user, abilities: [:manage_central])

      execute query, as: user, variables: {
        input: {
          userInput: {
            email: 'john@kimmel.com',
            firstName: 'John',
            lastName: 'Doe'
          }
        }
      }

      user = User.first
      expect(user.first_name).to eq('John')
    end
  end
end
