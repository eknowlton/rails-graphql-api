require "rails_helper"

RSpec.describe User, type: :model do
  context "validations" do
    it "is valid with valid attributes" do
      expect(build(:user)).to be_valid
    end

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:token_version) }

    it "is not valid with a non-unique email" do
      user = create(:user)
      duplicate_user = build(:user, email: user.email)

      expect(duplicate_user).not_to be_valid
    end
  end

  describe ".active" do
    it "can find active users" do
      user = create(:user)

      found_user = described_class.active.first

      expect(found_user).to eq(user)
    end

    it "does not find suspended users" do
      create(:user, :suspended)

      found_user = described_class.active.first

      expect(found_user).to be(nil)
    end
  end

  describe "#guest?" do
    it "returns false" do
      user = User.new

      result = user.guest?

      expect(result).to be(false)
    end
  end

  describe "#abilites" do
    it "returns the abilities that are assigned to a user" do
      ability = Abilities.first
      user = described_class.new
      user.permissions.new(ability: ability)

      abilities = user.abilities

      expect(abilities).to include(ability)
    end

    it "returns any abilities the user has gained from their role" do
      ability = Abilities.first
      role = create(:role)
      role.permissions.create(ability: ability)
      user = described_class.new(role: role)

      abilities = user.abilities

      expect(abilities).to include(ability)
    end
  end

  describe "#abilities=" do
    it "assigns temporary abilities to the user" do
      first_ability, second_ability = Abilities.take(2)
      user = create(:user)

      user.abilities = [first_ability, second_ability]

      expect(user.abilities).to include(first_ability, second_ability)
      expect(User.first.abilities).not_to include(first_ability, second_ability)
    end

    it "does not assign abilities that do not exist" do
      user = create(:user)

      user.abilities = [:fake_ability]

      expect(user.abilities).not_to include(:fake_ability)
    end
  end

  describe "#can?" do
    it "returns true if the user has the ability to perform the specified action" do
      ability = Abilities.first
      user = described_class.new(abilities: [ability])

      can = user.can?(ability)

      expect(can).to be(true)
    end

    it "returns false if the user does not have the ability to perform the specified action" do
      user = described_class.new

      can = user.can?(:do_anything)

      expect(can).to be(false)
    end
  end

  describe "#suspend" do
    it "makes the user inactive" do
      user = create(:user, active: true)

      user.suspend

      expect(user.active).to be(false)
    end
  end

  describe "#update_password" do
    it "confirms the current password and then changes it" do
      user = create(:user, password: "original")
      original_password = user.password_digest

      result = user.update_password(current: "original", new: "new_password")

      expect(result).to be(true)
      expect(user.reload.password_digest).not_to eq(original_password)
    end

    it "does not update the password if the provided current password does not match" do
      user = create(:user, password: "original")
      original_password = user.password_digest

      result = user.update_password(current: "not_a_match", new: "new_password")

      expect(result).to be(false)
      expect(user.reload.password_digest).to eq(original_password)
    end
  end

  describe "#admin?" do
    it "returns true if the user is an admin" do
      user = create(:user, abilities: [:manage_testmydev])

      result = user.admin?

      expect(result).to be(true)
    end

    it "returns false if the user is not an admin" do
      user = create(:user, abilities: [])

      result = user.admin?

      expect(result).to be(false)
    end
  end

  describe "#invalidate_tokens" do
    it "increments the token_version" do
      user = create(:user, token_version: 2)

      result = user.invalidate_tokens

      expect(result).to be(true)
      expect(user.token_version).to be(3)
    end
  end
end
