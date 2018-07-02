class RefreshToken
  ALGORITHM = 'HS256'.freeze

  def self.issue(user)
    JWT.encode(payload(user), secret, ALGORITHM)
  end

  def self.decode(token)
    new(JWT.decode(token, secret, algorithm: ALGORITHM).first.symbolize_keys)
  rescue JWT::DecodeError
    new(email: nil, version: 0)
  end

  attr_reader :email, :version

  def initialize(email:, version:, **)
    @email = email
    @version = version
  end

  def user
    @user ||= User.active.find_by(email: email)
  end

  def valid?
    user&.token_version == version
  end

  class << self
    private

    def payload(user)
      {
        email: user.email,
        exp: expiration,
        version: user.token_version
      }
    end

    def secret
      Rails.application.credentials[:jwt_refresh_secret]
    end

    def expiration
      7.days.from_now.to_i
    end
  end
end
