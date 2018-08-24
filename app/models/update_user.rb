class UpdateUser
  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def call
    if user.update(params)
      notify_user_updated(user)
      Result.success(user: user)
    else
      Result.failure(user.errors)
    end
  end

  private

  attr_reader :user, :params

  def notify_user_updated(user)
    DeliveryBoy.deliver_async(
      UserUpdatedEvent.new(user).to_json,
      topic: "user_#{Rails.env}",
      partition_key: user.id
    )
  end
end
