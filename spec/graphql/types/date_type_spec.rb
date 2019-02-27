require "rails_helper"

describe Types::DateType do
  describe ".coerce_input" do
    it "returns the date if it is in the correct format" do
      date = described_class.coerce_input("2017-01-01", {})

      expect(date).to eq("2017-01-01")
    end

    it "returns nil for an invalid date" do
      date = described_class.coerce_input("abcdef", {})

      expect(date).to be(nil)
    end
  end
end
