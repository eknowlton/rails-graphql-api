require 'rails_helper'

RSpec.describe SyncAbilities do
  describe '#call' do
    it 'creates permissions for a user' do
      first_ability, second_ability = Abilities.take(2)
      user = create(:user)

      result = described_class.new(user, [first_ability, second_ability]).call

      expect(result.success?).to eq(true)
      expect(user.abilities).to include(first_ability, second_ability)
    end

    it 'creates permissions for a role' do
      first_ability, second_ability = Abilities.take(2)
      role = create(:role)

      result = described_class.new(role, [first_ability, second_ability]).call

      expect(result.success?).to eq(true)
      expect(role.abilities).to include(first_ability, second_ability)
    end

    it 'removes existing permissions if they are not represented in the abilities array' do
      first_ability, second_ability = Abilities.take(2)
      user = create(:user)
      user.permissions.create(ability: second_ability)

      described_class.new(user, [first_ability]).call

      expect(user.abilities).to include(first_ability)
      expect(user.abilities).not_to include(second_ability)
    end

    it 'does not create permissions on the user that are already provided by the role' do
      role_ability = Abilities.first
      role = create(:role)
      role.permissions.create(ability: role_ability)

      user_ability = Abilities.second
      user = create(:user, role: role)
      user.permissions.create(ability: user_ability)

      result = described_class.new(user, [user_ability, role_ability]).call

      expect(result.success?).to eq(true)
      expect(user.abilities).to include(user_ability, role_ability)
      expect(user.permissions).not_to include(ability: role_ability)
    end
  end
end
