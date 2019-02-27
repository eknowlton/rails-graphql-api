Sidekiq.configure_server do |config|
  config.redis = {
    url: Rails.application.credentials.dig(Rails.env.to_sym, :redis_url),
    namespace: "sidekiq_central_#{Rails.env}",
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: Rails.application.credentials.dig(Rails.env.to_sym, :redis_url),
    namespace: "sidekiq_central_#{Rails.env}",
  }
end
