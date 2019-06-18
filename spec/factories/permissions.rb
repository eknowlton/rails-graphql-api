FactoryBot.define do
  factory :permission do
    ability { Abilities.first }
    association :permissable, factory: :user
  end
end
