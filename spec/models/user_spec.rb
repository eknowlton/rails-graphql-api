require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      expect(build(:user)).to be_valid
    end

    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(8) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    it 'is not valid with a non-unique email' do
      user = create(:user)
      duplicate_user = build(:user, email: user.email)

      expect(duplicate_user).not_to be_valid
    end
  end

  describe '.active' do
    it 'can find active users' do
      user = create(:user)

      found_user = described_class.active.first

      expect(found_user).to eq(user)
    end

    it 'does not find suspended users' do
      create(:user, :suspended)

      found_user = described_class.active.first

      expect(found_user).to be(nil)
    end
  end

  describe '#guest?' do
    it 'returns false' do
      user = User.new

      result = user.guest?

      expect(result).to be(false)
    end
  end
end
