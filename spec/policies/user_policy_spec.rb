require 'rails_helper'

RSpec.describe UserPolicy do
  describe '#manage?' do
    it 'returns true' do
      user = build_stubbed(:user)
      policy = described_class.new(user)

      result = policy.manage?

      expect(result).to be(true)
    end
  end
end
