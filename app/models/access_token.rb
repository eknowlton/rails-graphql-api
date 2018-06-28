class AccessToken < Token
  class << self
    private

    def payload(user)
      {
        **super,
        abilities: user.abilities
      }
    end

    def secret
      Rails.application.credentials[:jwt_access_secret]
    end

    def expiration
      1.day.from_now.to_i
    end
  end
end
