class Api::LeadsController < ApiController
  def create
    lead = Lead.create!(
      host: params[:host],
      path: params[:path],
      query: params[:query],
      referrer: params[:referrer],
      ip_address: request.remote_ip,
      user_agent: request.user_agent,
    )

    success(LeadBlueprint.render_as_hash(lead))
  end

  def update
    lead = Lead.new
    lead.id = SecureRandom.uuid

    success(LeadBlueprint.render_as_hash(lead))
  end

  def status
    lead = SecureRandom.uuid

    success(LeadBlueprint.render_as_hash(lead))
  end
end
