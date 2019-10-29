require "rails_helper"

describe "Delete Role Mutation API", :graphql do
  describe "deleteRole" do
    let(:query) do
      <<~'GRAPHQL'
        mutation($input: DeleteRoleInput!) {
          deleteRole(input: $input) {
            success
          }
        }
      GRAPHQL
    end

    it "deletes the specified role" do
      user = build(:user, abilities: [:manage_testmydev])
      role = create(:role)

      result = execute query, as: user, variables: {input: {id: role.id}}

      expect(result[:data][:deleteRole][:success]).to be(true)
      expect(role.reload.deleted_at).not_to be(nil)
    end
  end
end
