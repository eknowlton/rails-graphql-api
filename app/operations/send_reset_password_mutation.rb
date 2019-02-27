class SendResetPasswordMutation < Types::BaseMutation
  description "Triggers a reset password email"

  argument :email, String, required: true

  field :success, Boolean, null: false

  def resolve
    result = CreateResetPasswordToken.new(find_user).call

    if result.success?
      {success: true}
    else
      {success: false}
    end
  end

  private

  def find_user
    User.find_by(email: input.email)
  end
end
