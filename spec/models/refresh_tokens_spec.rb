require 'rails_helper'

RSpec.describe RefreshTokens do
  it 'returns a new access and refresh token when provided with a valid refresh token' do
    user = create(:user)
    token = RefreshToken.issue(user)
    refresh_tokens = described_class.new(token.body)

    result = refresh_tokens.call

    expect(result.success?).to be(true)
    expect(result.access_token).to be_a(AccessToken)
    expect(result.access_token.body).not_to be_nil
    expect(result.refresh_token).to be_a(RefreshToken)
    expect(result.refresh_token.body).not_to be_nil
    expect(result.user).to eq(user)
  end

  it 'fails when provided with an invalid refresh token' do
    refresh_tokens = described_class.new('invalid-token')

    result = refresh_tokens.call

    expect(result.success?).to be(false)
  end
end
