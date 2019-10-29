require "rails_helper"

RSpec.describe UserPolicy do
  describe "#manage?" do
    it "returns true if the user can manage other users" do
      user = build_stubbed(:user, abilities: [:manage_testmydev])
      policy = described_class.new(user)

      result = policy.manage?

      expect(result).to be(true)
    end
  end
end
