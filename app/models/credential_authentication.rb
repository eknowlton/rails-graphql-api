class CredentialAuthentication
  attr_reader :email, :password

  def initialize(email:, password:)
    @email = email
    @password = password
  end

  def authenticate
    if user&.authenticate(password)
      Result.success(token: Token.issue(user), user: user)
    else
      Result.failure(errors: ['Invalid email or password'])
    end
  end

  private

  def user
    @user ||= User.active.find_by(email: email)
  end
end
