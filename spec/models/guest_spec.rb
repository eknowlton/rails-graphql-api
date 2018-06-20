require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe '#guest?' do
    it 'returns true' do
      user = Guest.new

      result = user.guest?

      expect(result).to be(true)
    end
  end
end
