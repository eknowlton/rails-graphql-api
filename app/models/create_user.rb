class CreateUser
  def initialize(params)
    @params = params
  end

  def call
    user = new_user

    if user.save
      Result.success(user: user)
    else
      Result.failure(user.errors)
    end
  end

  private

  attr_reader :params

  def new_user
    User.new(
      **params,
      password: random_password
    )
  end

  def random_password
    SecureRandom.base64(10)
  end
end
