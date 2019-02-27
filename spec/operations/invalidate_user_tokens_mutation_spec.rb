require "rails_helper"

describe "Invalidate User Tokens Mutation API", :graphql do
  describe "invalidateUserTokens" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: InvalidateUserTokensInput!) {
          invalidateUserTokens(input: $input) {
            user {
              id
            }
          }
        }
      GRAPHQL
    end

    it "Invalidates all previously issued tokens for a user" do
      acting_user = build(:user, abilities: [:manage_central])
      user = create(:user, token_version: 1)
      token_body = RefreshToken.issue(user)

      execute query, as: acting_user, variables: {
        input: {
          id: user.id,
        },
      }

      expect(user.reload.token_version).to eq(2)
      expect(RefreshToken.decode(token_body).valid?).to be(false)
    end
  end
end
