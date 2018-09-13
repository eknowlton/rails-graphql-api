class AccessToken
  ALGORITHM = 'HS256'.freeze

  def self.issue(user)
    JWT.encode(payload(user), secret, ALGORITHM)
  end

  def self.decode(token)
    new(JWT.decode(token, secret, algorithm: ALGORITHM).first.symbolize_keys)
  rescue JWT::DecodeError
    new(email: nil, abilities: [])
  end

  attr_reader :email, :abilities

  def initialize(email:, abilities:, **)
    @email = email
    @abilities = abilities
  end

  def user
    @user ||= User.active.find_by(email: email)
  end

  def valid?
    user.present?
  end

  class << self
    private

    def payload(user)
      {
        email: user.email,
        exp: expiration,
        abilities: user.abilities
      }
    end

    def secret
      Rails.application.credentials[Rails.env.to_sym][:jwt_access_secret]
    end

    def expiration
      1.day.from_now.to_i
    end
  end
end
