class Api::LeadsController < ApiController
  def index
    success
  end

  def create
    success
  end

  def status
    lead = Lead.new

    success(LeadBlueprint.render_as_hash(lead))
  end
end
