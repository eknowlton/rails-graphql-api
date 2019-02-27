require "rails_helper"

describe "Impersonate User Mutation API", :graphql do
  describe "impersonateUser" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: ImpersonateUserInput!) {
          impersonateUser(input: $input) {
            user {
              email
            }
            refreshToken
            accessToken
          }
        }
      GRAPHQL
    end

    it "provides tokens for the specified user" do
      user = build(:user, abilities: [:manage_central])
      impersonated_user = create(:user)

      result = execute query, as: user, variables: {
        input: {
          userId: impersonated_user.id,
        },
      }

      impersonate_user = result[:data][:impersonateUser]
      expect(impersonate_user[:user][:email]).to eq(impersonated_user.email)
      expect(impersonate_user[:accessToken]).not_to be_nil
      expect(impersonate_user[:refreshToken]).not_to be_nil
    end
  end
end
