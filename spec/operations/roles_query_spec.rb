require "rails_helper"

describe "Roles Query API", :graphql do
  describe "roles" do
    let(:query) do
      <<~'GRAPHQL'
        query {
          roles {
            id
          }
        }
      GRAPHQL
    end

    it "gets all roles" do
      role = create(:role)

      result = execute query, as: build(:user)

      roles = result[:data][:roles]
      expect(roles).to include(id: role.id.to_s)
    end
  end
end
