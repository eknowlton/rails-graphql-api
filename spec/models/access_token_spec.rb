require 'rails_helper'

RSpec.describe AccessToken do
  describe '.issue' do
    it 'creates a token for the provided user' do
      user = create(:user)

      token = AccessToken.issue(user)

      expect(token).not_to be_nil
      expect(token).to be_a(AccessToken)
      expect(token.body).not_to be_nil
    end
  end

  describe '.decode' do
    it 'it decodes the provided token body' do
      user = create(:user)
      token = AccessToken.issue(user)

      decoded_token = AccessToken.decode(token.body)

      expect(decoded_token['email']).to eq(user.email)
    end

    it 'it contains the users abilities' do
      user = create(:user, abilities: [:manage_central])
      token = AccessToken.issue(user)

      decoded_token = AccessToken.decode(token.body)

      expect(decoded_token['abilities']).to include('manage_central')
    end
  end
end
