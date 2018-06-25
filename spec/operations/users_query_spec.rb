require 'rails_helper'

describe 'Users Query API', :graphql do
  describe 'users' do
    let(:query) do
      <<~'GRAPHQL'
        query {
          users {
            id
          }
        }
      GRAPHQL
    end

    it 'gets all users' do
      user = create(:user)

      result = execute query, as: user

      users = result[:data][:users]
      expect(users).to include(id: user.id.to_s)
    end
  end
end
