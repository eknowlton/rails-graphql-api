require "rails_helper"

RSpec.describe RolePolicy do
  describe "#manage?" do
    it "returns if the user can manage roles" do
      user = build_stubbed(:user, abilities: [:manage_central])
      policy = described_class.new(user)

      result = policy.manage?

      expect(result).to be(true)
    end
  end
end
