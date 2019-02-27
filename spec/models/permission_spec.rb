require "rails_helper"

RSpec.describe Permission, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      expect(build(:permission)).to be_valid
    end

    it { should validate_presence_of(:ability) }
    it { should_not allow_value(:not_a_real_ability).for(:ability) }

    it "is not valid if the permission is duplicated" do
      permission = create(:permission)
      another_permission = build(:permission,
        ability: permission.ability,
        permissable: permission.permissable)

      expect(another_permission).not_to be_valid
    end
  end

  describe "#ability" do
    it "converts the ability to a symbol" do
      ability = Abilities.first
      permission = described_class.new(ability: ability.to_s)

      permission_ability = permission.ability

      expect(permission_ability).to eq(ability.to_sym)
    end
  end
end
