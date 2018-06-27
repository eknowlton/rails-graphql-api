require 'rails_helper'

describe 'Send Reset Password Mutation API', :graphql do
  describe 'sendResetPassword' do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: SendResetPasswordInput!) {
          sendResetPassword(input: $input) {
            success
          }
        }
      GRAPHQL
    end

    it 'triggers a reset password' do
      create(:user, email: 'john@kimmel.com')

      execute query, variables: {
        input: {
          email: 'john@kimmel.com'
        }
      }

      expect(ResetPasswordToken.count).to eq(1)
    end
  end
end
