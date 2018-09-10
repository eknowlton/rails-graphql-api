require 'rails_helper'

RSpec.describe CreateUsersFromCSV do
  it 'creates a user specified in csv format' do
    file_path = 'spec/fixtures/test_users.csv'

    results = CreateUsersFromCSV.new(file_path).call

    expect(User.count).to eq(2)
    expect(results[:successes].count).to eq(2)
  end
end
