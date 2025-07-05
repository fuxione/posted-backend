class ApiController < ActionController::API
  rescue_from ActionController::UnpermittedParameters, with: :unpermitted_params
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def success(data = nil)
    payload = {
      status: "success",
      data: data,
      meta: { seq: params[:seq] || 0 }
    }
    render json: payload
  end

  def error(messages, code = 422)
    render json: {
      status: "error",
      messages: messages
    }, status: code
  end

  private

  def unpermitted_params(e)
    error(e.message)
  end

  def not_found
    error("resource not found", 404)
  end
end
