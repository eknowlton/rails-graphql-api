class BroadcastUser
  def initialize(user)
    @user = user
  end

  def call
    DeliveryBoy.deliver_async(
      UserEvent.new(user).to_json,
      topic: "user",
      key: "user-#{user.id}",
      partition_key: user.id
    )
  end

  private

  attr_reader :user
end
