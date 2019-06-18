FactoryBot.define do
  factory :user do
    walter_id { 1 }
    intranet_id { 1 }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    abbreviation { Faker::Name.initials }
    title { Faker::Job.title }
    hire_date { Faker::Date.between(10.years.ago, Date.current) }
    active { true }

    trait :suspended do
      active { false }
    end
  end
end
