class CreateUser
  def initialize(params)
    @params = params
  end

  def call
    user = new_user

    if user.save
      send_welcome(user)
      Result.success(user: user)
    else
      Result.failure(user.errors)
    end
  end

  private

  attr_reader :params

  def new_user
    User.new(
      **params,
      password: random_password
    )
  end

  def random_password
    SecureRandom.base64(10)
  end

  def send_welcome(user)
    ResetPasswordToken.create(user: user)
    SendWelcomeEmailJob.perform_later(user.id)
  end
end
