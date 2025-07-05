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
    lead = Lead.find(params[:id])

    if lead.update(lead_params)
      return success(LeadBlueprint.render_as_hash(lead))
    end

    error(lead.errors.full_messages)
  end

  def status
    lead = SecureRandom.uuid

    success(LeadBlueprint.render_as_hash(lead))
  end

  private

  def lead_params
    params.permit(
      attributes: Lead::ATTRIBUTES,
      fields: Lead::FIELDS,
    )
  end
end
