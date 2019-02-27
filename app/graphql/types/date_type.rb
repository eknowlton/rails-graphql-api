module Types
  class DateType < Types::BaseScalar
    description "Date in ISO 8601 format: yyyy-mm-dd"

    def self.coerce_input(value, _ctx)
      coerce_date(value)
    end

    def self.coerce_result(value, _ctx)
      value.to_s
    end

    def self.coerce_date(input)
      Date.strptime(input).to_s
    rescue
      nil
    end
  end
end
