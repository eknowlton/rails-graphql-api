require 'rails_helper'

RSpec.describe Role, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      expect(build(:role)).to be_valid
    end

    it { should validate_presence_of(:name) }

    it 'is not valid with a non-unique name' do
      role = create(:role)
      duplicate_role = build(:role, name: role.name)

      expect(duplicate_role).not_to be_valid
    end
  end
end
