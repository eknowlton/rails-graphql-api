require "rails_helper"

RSpec.describe ApplicationPolicy do
  describe "#logged_in?" do
    it "returns true for a user" do
      user = User.new
      policy = described_class.new(user)

      logged_in = policy.logged_in?

      expect(logged_in).to be(true)
    end

    it "returns false for a guest" do
      user = Guest.new
      policy = described_class.new(user)

      logged_in = policy.logged_in?

      expect(logged_in).to be(false)
    end
  end
end
