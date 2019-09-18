require "rails_helper"

RSpec.describe BroadcastUser do
  describe "#call" do
    it "broadcasts the user object" do
      user = build_stubbed(:user, email: "john@kimmel.com")

      described_class.new(user).call

      messages = DeliveryBoy.testing.messages_for("kimmel")
      expect(messages.count).to eq(1)
      event = JSON.parse(messages.first.value)
      expect(event["type"]).to eq("user")
      expect(event["data"]["email"]).to eq("john@kimmel.com")
    end
  end
end
