class ResetPasswordToken < ApplicationRecord
  belongs_to :user

  validates :body, uniqueness: true

  has_secure_token :body
end
