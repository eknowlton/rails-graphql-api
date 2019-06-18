FactoryBot.define do
  factory :refresh_token do
    email { create(:user).email }
    version { 1 }

    skip_create
    initialize_with { new(attributes) }
  end
end
