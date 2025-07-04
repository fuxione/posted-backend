class ApiController < ActionController::API
  before_action :set_seq

  def success(data = nil)
    render json: { status: "success", data: data, seq: @seq }
  end

  def error(messages, code = 422)
    render json: { status: "error", errors: messages, seq: @seq }, status: code
  end

  private

  def set_seq
    @seq = params[:seq] || 0
  end
end
