class RefreshToken < Token
  class << self
    private

    def secret
      Rails.application.credentials[:jwt_refresh_secret]
    end

    def expiration
      7.days.from_now.to_i
    end
  end
end
