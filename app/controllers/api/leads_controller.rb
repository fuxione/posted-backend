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

    lead.assign_fields!(params[:internal_fields], Lead::INTERNAL_FIELDS)
    lead.assign_fields!(params[:user_fields], Lead::USER_FIELDS)

    lead.evaluate_meta_fields(params[:meta_fields])

    if lead.save
      return success(LeadBlueprint.render_as_hash(lead))
    end

    error(lead.errors.full_messages)
  end

  def status
    lead = Lead.find(params[:id])

    success(LeadBlueprint.render_as_hash({
      status: "PENDING"
    }))
  end
end
