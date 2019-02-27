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

    delegate :authorized?, to: :class

    def resolver(**args)
      @input = OpenStruct.new(args)
      if respond_to?(:authorized_resolve)
        authorize
        authorized_resolve
      else
        resolve
      end
    end

    def resolve
    end

    def authorize(record = nil)
      return if authorized?(current_user, record)
      if current_user.guest?
        authenticated_error
      else
        authorized_error
      end
    end

    def current_user
      context[:current_user]
    end

    private

    def authenticated_error
      raise GraphQL::ExecutionError.new(
        "You must be authenticated to access #{self.class.graphql_name}",
        extensions: {code: "UNAUTHENTICATED"}
      )
    end

    def authorized_error
      raise GraphQL::ExecutionError.new(
        "You don't have permission to access #{self.class.graphql_name}",
        extensions: {code: "UNAUTHORIZED"}
      )
    end

    class_methods do
      attr_reader :policy_class, :policy_method

      def policy(policy_class, policy_method)
        @policy_class = policy_class
        @policy_method = policy_method
      end

      def authorized?(current_user, record = nil)
        policy_class.new(current_user, record).send(policy_method)
      end
    end
  end
end
