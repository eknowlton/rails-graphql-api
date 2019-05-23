Sidekiq.configure_server do |config|
  config.redis = {
    url: ENV.fetch("REDIS_URL") { "localhost:6379" },
    namespace: "sidekiq_central_#{Rails.env}",
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: ENV.fetch("REDIS_URL") { "localhost:6379" },
    namespace: "sidekiq_central_#{Rails.env}",
  }
end
