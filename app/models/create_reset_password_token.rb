class CreateResetPasswordToken
  def initialize(user)
    @user = user
  end

  def call
    reset_password_token = ResetPasswordToken.new(user: user)

    if reset_password_token.save
      send_reset_password_email
      Result.success(reset_password_token: reset_password_token)
    else
      Result.failure(reset_password_token.errors)
    end
  end

  private

  attr_reader :user

  def send_reset_password_email
    SendPasswordResetEmailJob.perform_later(user.id)
  end
end
