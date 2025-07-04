class ApiController < ActionController::API
  def success(data = nil)
    payload = { status: "success", data: data }
    payload[:seq] = params[:seq] if params[:seq].present?
    render json: payload
  end

  def error(messages, code = 422)
    render json: { status: "error", errors: messages }, status: code
  end
end
