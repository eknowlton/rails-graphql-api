module Types
  class AbilityType < Types::BaseEnum
    description "An ability that grants permissions"
    Abilities.each do |ability|
      value ability.upcase, value: ability.to_sym
    end
  end
end
