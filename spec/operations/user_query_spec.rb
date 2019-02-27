require "rails_helper"

describe "User Query API", :graphql do
  describe "user" do
    let(:query) do
      <<~'GRAPHQL'
        query($id: ID!) {
          user(id: $id) {
            email
          }
        }
      GRAPHQL
    end

    it "gets the user with the specified id" do
      user = create(:user)

      result = execute query, as: build(:user), variables: {id: user.id}

      email = result[:data][:user][:email]
      expect(email).to eq(user.email)
    end
  end

  describe "user abilities" do
    let(:query) do
      <<~'GRAPHQL'
        query($id: ID!) {
          user(id: $id) {
            abilities
          }
        }
      GRAPHQL
    end

    it "gets the specified user with abilities" do
      ability = Abilities.first
      user = create(:user)
      user.permissions.create(ability: ability)

      result = execute query, as: build(:user), variables: {id: user.id}

      abilities = result[:data][:user][:abilities]
      expect(abilities).to include(ability.to_s.upcase)
    end
  end
end
