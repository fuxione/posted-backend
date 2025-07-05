class Api::LeadsController < ApiController
  def create
    lead = Lead.create!(
      wid: params[:wid],
      vertical: params[:vertical],
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

    lead.assign_fields(params[:fields])

    # save clears previous errors, so we have to check prior to saving.
    # normally one would never need to do this, except that we want full
    # manual control over the whitelisted fields, some of which are virtual
    return error(lead.errors.full_messages) if lead.errors.any?

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
