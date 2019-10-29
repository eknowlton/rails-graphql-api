class UpdateUser
  def initialize(user:, params:)
    @user = user
    @params = params
  end

  def call
    if user.update(params)
      Result.success(user: user)
    else
      Result.failure(user.errors)
    end
  end

  private

  attr_reader :user, :params
end
