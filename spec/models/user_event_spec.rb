require "rails_helper"

RSpec.describe UserEvent do
  describe "#to_json" do
    it "creates a json encoded event" do
      user = create(:user)

      result = described_class.new(user).to_json

      event = JSON.parse(result)
      expect(event["type"]).to eq("user")
      expect(event["data"]["email"]).to eq(user.email)
    end
  end
end
