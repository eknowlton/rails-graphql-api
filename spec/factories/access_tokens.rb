FactoryBot.define do
  factory :access_token do
    email { create(:user).email }
    abilities []

    skip_create
    initialize_with { new(attributes) }
  end
end
