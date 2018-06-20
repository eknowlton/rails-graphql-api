class Token
  ALGORITHM = 'HS256'.freeze
  EXPIRATION = 7.days.from_now.to_i

  attr_reader :body

  def self.issue(user)
    new(body: JWT.encode(payload(user), secret, ALGORITHM))
  end

  def self.decode(token)
    JWT.decode(token, secret, algorithm: 'HS256').first
  rescue JWT::DecodeError
    false
  end

  def initialize(body:)
    @body = body
  end

  def self.payload(user)
    {
      email: user.email,
      exp: EXPIRATION
    }
  end
  private_class_method :payload

  def self.secret
    Rails.application.credentials[:jwt_secret]
  end
  private_class_method :secret
end
