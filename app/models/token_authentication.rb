class TokenAuthentication
  attr_reader :token_string

  def initialize(token_string:)
    @token_string = token_string
  end

  def authenticate
    data = Token.decode(token_string)
    return Guest.new unless data

    find_user(data['email']) || Guest.new
  end

  private

  def find_user(email)
    User.active.find_by(email: email)
  end
end
