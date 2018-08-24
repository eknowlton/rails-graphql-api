class CreateUser
  def initialize(params)
    @params = params
  end

  def call
    user = new_user

    if user.save
      send_welcome(user)
      notify_user_created(user)
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

  def notify_user_created(user)
    DeliveryBoy.deliver_async(
      UserCreatedEvent.new(user).to_json,
      topic: "user_#{Rails.env}",
      partition_key: user.id
    )
  end
end
