class Token
  ALGORITHM = 'HS256'.freeze

  attr_reader :body

  def self.issue(user)
    new(body: JWT.encode(payload(user), secret, ALGORITHM))
  end

  def self.decode(token)
    JWT.decode(token, secret, algorithm: ALGORITHM).first
  rescue JWT::DecodeError
    false
  end

  def initialize(body:)
    @body = body
  end

  class << self
    private

    def payload(user)
      {
        email: user.email,
        exp: expiration
      }
    end

    def secret
      raise NotImplementedError, "#{self.class.name}.secret should expose the secret"
    end

    def expiration
      raise NotImplementedError, "#{self.class.name}.expiration should define the validity period"
    end
  end
end
