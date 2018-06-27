# Preview all emails at http://localhost:3000/rails/mailers/password
class PasswordPreview < ActionMailer::Preview
  def reset_password
    user = User.first
    ResetPasswordToken.create(user: user)

    PasswordMailer.reset_password(user: user)
  end
end
