class SendPasswordResetEmailJob < ApplicationJob
  queue_as :default

  def perform(user_id)
    user = User.find(user_id)

    PasswordMailer.reset_password(user: user).deliver_now
  end
end
