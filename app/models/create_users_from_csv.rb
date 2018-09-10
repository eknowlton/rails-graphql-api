require 'csv'

class CreateUsersFromCSV
  def initialize(path)
    @file = File.read(path)
  end

  def call
    csv = CSV.parse(file, headers: true)
    results = csv.map do |row|
      CreateUser.new(row.to_h.symbolize_keys).call
    end
    {
      successes: results.select(&:success?),
      failures: results.reject(&:success?)
    }
  end

  private

  attr_accessor :file
end
