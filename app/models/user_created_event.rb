class UserCreatedEvent
  def initialize(user)
    @user = user
  end

  def to_json
    {
      type: 'user_created',
      published_at: Time.current,
      user: user_hash
    }.to_json
  end

  private

  attr_reader :user

  def user_hash
    {
      id: user.id,
      walter_id: user.walter_id,
      intranet_id: user.intranet_id,
      email: user.email,
      first_name: user.first_name,
      last_name: user.last_name
    }
  end
end
