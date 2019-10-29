require "rails_helper"

RSpec.describe UpdateUser do
  describe "#call" do
    it "updates the provided user" do
      user = create(:user)

      params = {
        email: "john@kimmel.com",
        first_name: "John",
      }

      result = described_class.new(user: user, params: params).call

      expect(result.success?).to be(true)
      expect(user.email).to eq("john@kimmel.com")
      expect(user.first_name).to eq("John")
    end

    it "returns errors when user is not valid" do
      user = create(:user, email: "john@kimmel.com")

      result = described_class.new(user: user, params: {email: nil}).call

      expect(result.success?).to eq(false)
      expect(result.errors.count).not_to eq(0)
      expect(user.reload.email).to eq("john@kimmel.com")
    end
  end
end
