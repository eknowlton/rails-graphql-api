require "rails_helper"

RSpec.describe WelcomeMailer, type: :mailer do
  describe ".welcome_email" do
    it "builds the mail" do
      user = create(:user)
      create(:reset_password_token, user: user)

      mail = described_class.welcome_email(user: user)

      expect(mail.subject).to eq("Welcome To Kimmel")
      expect(mail.to).to include(user.email)
      expect(mail.body.encoded).to include("Welcome to Kimmel!")
    end
  end
end
