class WelcomeMailer < ApplicationMailer
  def welcome_email(user:)
    @user = user
    @token = user.reset_password_token.body

    mail(to: @user.email, subject: "Welcome To Kimmel")
  end
end
