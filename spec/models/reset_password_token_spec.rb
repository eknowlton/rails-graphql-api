require 'rails_helper'

RSpec.describe ResetPasswordToken, type: :model do
  context 'validations' do
    it 'is valid with valid attributes' do
      expect(build(:reset_password_token)).to be_valid
    end

    it 'is not valid if token is not unique' do
      reset_password_token = create(:reset_password_token)
      another_reset_password_token = build(:reset_password_token, body: reset_password_token.body)

      expect(another_reset_password_token).not_to be_valid
    end
  end
end
