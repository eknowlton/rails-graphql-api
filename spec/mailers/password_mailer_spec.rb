require 'rails_helper'

RSpec.describe PasswordMailer, type: :mailer do
  describe '.reset_password' do
    it 'builds the mail' do
      user = create(:user)
      token = create(:reset_password_token, user: user)

      mail = described_class.reset_password(user: user)

      expect(mail.subject).to eq('Reset Password - Kimmel')
      expect(mail.to).to include(user.email)
      expect(mail.body.encoded).to include(token.body)
    end
  end
end
