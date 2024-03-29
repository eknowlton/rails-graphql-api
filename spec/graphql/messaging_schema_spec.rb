require "rails_helper"

RSpec.describe TestMyDevSchema do
  describe "schema dumps" do
    it "has updated schema dumps" do
      current_definition = TestMyDevSchema.to_definition
      current_json = TestMyDevSchema.to_json

      printout_definition = File.read(Rails.root.join("app", "graphql", "schema.graphql"))
      printout_json = File.read(Rails.root.join("app", "graphql", "schema.json"))

      expect(current_definition).to eq(printout_definition), message
      expect(current_json).to eq(printout_json), message
    end

    def message
      "Update the printed schema with `rake graphql:schema:dump`"
    end
  end
end
