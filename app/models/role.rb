class Role < ApplicationRecord
  has_many :permissions,
           as: :permissable,
           inverse_of: :permissable,
           dependent: :destroy

  validates :name, presence: true, uniqueness: true

  def abilities
    permissions.map(&:ability)
  end
end
