require 'rails_helper'

RSpec.describe TokenAuthentication do
  it 'returns the authenticated user with a valid token' do
    user = create(:user)
    token_body = AccessToken.issue(user)
    auth = described_class.new(token_string: token_body)

    authenticated_user = auth.authenticate

    expect(authenticated_user).to eq(user)
  end

  it 'returns a guest when provided with an invalid token' do
    auth = described_class.new(token_string: 'not-valid-token')

    guest_user = auth.authenticate

    expect(guest_user).to be_a(Guest)
  end

  it 'returns guest if the user is suspended' do
    user = create(:user, :suspended)
    token_body = AccessToken.issue(user)
    auth = described_class.new(token_string: token_body)

    guest_user = auth.authenticate

    expect(guest_user).to be_a(Guest)
  end
end
