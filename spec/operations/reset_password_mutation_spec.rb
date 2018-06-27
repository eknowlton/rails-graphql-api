require 'rails_helper'

describe 'Reset Password Mutation API', :graphql do
  describe 'resetPassword' do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: ResetPasswordInput!) {
          resetPassword(input: $input) {
            errors {
              field
              message
            }
            token {
              body
            }
          }
        }
      GRAPHQL
    end

    it 'updates a users password and returns an auth token when reset password token valid' do
      user = create(:user)
      create(:reset_password_token, user: user, body: 'someResetToken', created_at: Date.current)
      old_password = user.password_digest

      result = execute query, variables: {
        input: {
          password: 'newPassword',
          resetPasswordToken: 'someResetToken'
        }
      }

      auth_token_body = result[:data][:resetPassword][:token][:body]
      expect(auth_token_body).not_to be_nil
      expect(user.reload.password_digest).not_to eq(old_password)
    end
  end
end
