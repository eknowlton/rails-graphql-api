module Types
  module Operation
    extend ActiveSupport::Concern

    included do
      resolve_method :resolver
    end

    attr_reader :input

    def initialize(object:, context:)
      @object = object
      @context = context
    end

    def resolver(**args)
      @input = OpenStruct.new(args)
      resolve
    end

    def resolve; end
  end
end
