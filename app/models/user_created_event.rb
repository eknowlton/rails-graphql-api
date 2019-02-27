class UserCreatedEvent
  def initialize(user)
    @user = user
  end

  def to_json
    {
      type: "user_created",
      published_at: Time.current,
      user: user_hash,
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
      last_name: user.last_name,
      nickname: user.nickname,
      preferred_name: user.preferred_name,
      abbreviation: user.abbreviation,
      title: user.title,
      linkedin_url: user.linkedin_url,
      birth_date: user.birth_date,
      hire_date: user.hire_date,
    }
  end
end
