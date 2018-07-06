class UserCreatedEvent
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def to_json
    {
      type: 'user_created',
      user: {
        email: user.email,
        first_name: user.first_name,
        last_name: user.last_name,
      },
      published_at: Time.current
    }.to_json
  end
end
