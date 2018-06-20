require 'rails_helper'

RSpec.describe SendWelcomeEmailJob, type: :job do
  describe '#perform' do
    it 'sends a email to the specified user' do
      user = create(:user)
      create(:reset_password_token, user: user)

      described_class.new.perform(user.id)

      delivery = ActionMailer::Base.deliveries.last
      expect(delivery.to).to include(user.email)
    end
  end
end
