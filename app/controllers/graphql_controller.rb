class GraphqlController < ApplicationController
  def execute
    result = CentralSchema.execute(
      params[:query],
      variables: ensure_hash(params[:variables]),
      context: {},
      operation_name: params[:operationName]
    )
    render json: result
  end

  private

  def ensure_hash(ambiguous_param)
    case ambiguous_param
    when String
      string_param(ambiguous_param)
    when Hash, ActionController::Parameters
      ambiguous_param
    when nil
      {}
    else
      raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
    end
  end

  def string_param(ambiguous_param)
    if ambiguous_param.present?
      ensure_hash(JSON.parse(ambiguous_param))
    else
      {}
    end
  end
end
