require 'rails_helper'

RSpec.describe CreateUser do
  describe '#call' do
    it 'creates a new user with a random password' do
      params = {
        email: 'john@kimmel.com',
        first_name: 'John',
        last_name: 'Doe'
      }

      result = described_class.new(params).call

      expect(User.count).to eq(1)
      user = User.first
      expect(user.password_digest).not_to eq(nil)
      expect(result.success?).to be(true)
    end

    it 'sends a welcome email' do
      params = {
        email: 'john@kimmel.com',
        first_name: 'John',
        last_name: 'Doe'
      }

      result = perform_enqueued_jobs do
        described_class.new(params).call
      end

      delivery = ActionMailer::Base.deliveries.last
      expect(delivery.to).to include(result.user.email)
    end

    it 'returns errors when user is not valid' do
      params = {
        first_name: 'John',
        last_name: 'Doe'
      }

      result = described_class.new(params).call

      expect(User.count).to eq(0)
      expect(result.success?).to eq(false)
      expect(result.errors.count).not_to eq(0)
    end
  end
end
