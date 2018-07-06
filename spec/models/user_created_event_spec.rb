require 'rails_helper'

RSpec.describe UserCreatedEvent do
  describe '#to_json' do
    it 'creates a json encoded event' do
      user = create(:user)

      result = described_class.new(user).to_json

      event = JSON.parse(result)
      expect(event['type']).to eq('user_created')
      expect(event['user']['email']).to eq(user.email)
    end
  end
end
