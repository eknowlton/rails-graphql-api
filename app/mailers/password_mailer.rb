class PasswordMailer < ApplicationMailer
  def reset_password(user:)
    @user = user
    @token = user.reset_password_token.body
    @date = Date.current

    mail(to: @user.email, subject: 'Reset Password - Kimmel')
  end
end
