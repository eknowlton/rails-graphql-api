FactoryBot.define do
  factory :role do
    name { Faker::Lorem.sentence(3) }
  end
end
