FactoryBot.define do
  factory :user do
    walter_id 1
    intranet_id 1
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    active true

    trait :suspended do
      active false
    end
  end
end
