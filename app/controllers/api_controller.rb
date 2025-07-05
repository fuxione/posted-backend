class ApiController < ActionController::API
  def success(data = nil)
    payload = { status: "success", data: data, meta: { seq: params[:seq] || 0 } }
    render json: payload
  end

  def error(messages, code = 422)
    render json: { status: "error", errors: messages }, status: code
  end
end
