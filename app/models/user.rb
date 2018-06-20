class User < ApplicationRecord
  has_one :reset_password_token,
          -> { order(created_at: :desc) },
          inverse_of: :user,
          dependent: :destroy

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, allow_nil: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_secure_password

  scope :active, -> { where(active: true) }

  def guest?
    false
  end
end
