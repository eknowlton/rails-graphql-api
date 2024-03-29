require "rails_helper"

RSpec.describe CredentialAuthentication do
  it "returns an access token and refresh token when provided with a valid email and password" do
    user = create(:user, password: "test-password")
    auth = described_class.new(email: user.email, password: "test-password")

    result = auth.authenticate

    expect(result.success?).to be(true)
    expect(result.access_token).not_to be_nil
    expect(result.refresh_token).not_to be_nil
    expect(result.user).to eq(user)
  end

  it "fails when provided with a email that does not exist" do
    auth = described_class.new(email: "not-valid@test.com", password: "password")

    result = auth.authenticate

    expect(result.success?).to be(false)
  end

  it "fails when provided with an invalid password" do
    user = create(:user)
    auth = described_class.new(email: user.email, password: "not-valid-email")

    result = auth.authenticate

    expect(result.success?).to be(false)
  end

  it "fails if the user is suspended" do
    user = create(:user, :suspended, password: "test-password")
    auth = described_class.new(email: user.email, password: "test-password")

    result = auth.authenticate

    expect(result.success?).to be(false)
  end
end
