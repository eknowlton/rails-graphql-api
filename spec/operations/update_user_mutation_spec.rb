require "rails_helper"

describe "Update User Mutation API", :graphql do
  describe "updateUser" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: UpdateUserInput!) {
          updateUser(input: $input) {
            user {
              firstName
            }
          }
        }
      GRAPHQL
    end

    it "updates the specified user" do
      user = create(:user)
      acting_user = build(:user, abilities: [:manage_testmydev])

      result = execute query, as: acting_user, variables: {
        input: {
          id: user.id,
          userInput: {
            firstName: "Alex",
          },
        },
      }

      first_name = result[:data][:updateUser][:user][:firstName]
      expect(first_name).to eq("Alex")
      expect(user.reload.first_name).to eq("Alex")
    end
  end
end
