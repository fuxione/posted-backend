class Api::LeadsController < ApiController
  def create
    lead = Lead.new
    lead.id = Uuid.generate

    success(LeadBlueprint.render_as_hash(lead))
  end

  def update
    lead = Lead.new
    lead.id = Uuid.generate

    success(LeadBlueprint.render_as_hash(lead))
  end

  def status
    lead = Lead.new

    success(LeadBlueprint.render_as_hash(lead))
  end
end
