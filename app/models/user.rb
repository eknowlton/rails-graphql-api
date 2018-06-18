class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, allow_nil: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_secure_password
end
