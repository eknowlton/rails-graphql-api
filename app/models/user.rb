class User < ApplicationRecord
  belongs_to :role, optional: true
  has_one :reset_password_token,
          -> { order(created_at: :desc) },
          inverse_of: :user,
          dependent: :destroy
  has_many :permissions,
           as: :permissable,
           inverse_of: :permissable,
           dependent: :destroy
  has_many :role_permissions, through: :role, source: :permissions

  validates :email, presence: true, uniqueness: true
  validates :password, length: { minimum: 8 }, allow_nil: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  has_secure_password

  scope :active, -> { where(active: true) }

  def guest?
    false
  end

  def abilities
    permissions.map(&:ability) + role_permissions.map(&:ability) + temp_abilities
  end

  def abilities=(new_abilities)
    @temp_abilities = new_abilities.reject { |ability| Abilities.exclude?(ability) }
  end

  def can?(action)
    abilities.include?(action.downcase.to_sym)
  end

  private

  def temp_abilities
    @temp_abilities ||= []
  end
end
