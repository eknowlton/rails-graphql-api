class Permission < ApplicationRecord
  belongs_to :permissable, polymorphic: true

  validates :ability,
    presence: true,
    inclusion: Abilities,
    uniqueness: {scope: :permissable}

  def ability
    self[:ability]&.to_sym
  end
end
