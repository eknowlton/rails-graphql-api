require 'rails_helper'
require 'json_schemer'
require 'json'

RSpec.describe 'User Created Schema' do
  it 'the user_created_event matches the schema' do
    user = create(:user)
    event = JSON.parse(UserCreatedEvent.new(user).to_json)
    schema = JSON.parse(File.read('app/json_schema/user_created_schema.json'))
    validator = JSONSchemer.schema(schema, format: true)

    result = validator.validate(event).to_a

    expect(result).to be_empty, message(result)
  end

  def message(result)
    <<~MESSAGE
      The format of `UserCreatedEvent` has changed. Update the schema and all consumers.
      The schema validation error was reported as:
      #{result}"
    MESSAGE
  end
end
