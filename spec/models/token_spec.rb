require 'rails_helper'

RSpec.describe Token do
  describe '.issue' do
    it 'creates a token for the provided user' do
      user = create(:user)

      token = Token.issue(user)

      expect(token).not_to be_nil
      expect(token).to be_a(Token)
      expect(token.body).not_to be_nil
    end
  end

  describe '.decode' do
    it 'it decodes the provided token body' do
      user = create(:user)
      token = Token.issue(user)

      decoded_token = Token.decode(token.body)

      expect(decoded_token['email']).to eq(user.email)
    end
  end
end
