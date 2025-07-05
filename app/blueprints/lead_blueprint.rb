# == Schema Information
#
# Table name: leads
#
#  id            :uuid             not null, primary key
#  address1      :string
#  address2      :string
#  city          :string
#  country       :string
#  date_of_birth :string
#  email         :string
#  fcra_consent  :boolean
#  fcra_language :text
#  first_name    :string
#  host          :string           not null
#  ip_address    :string           not null
#  last_name     :string
#  loan_amount   :string
#  loan_types    :string           is an Array
#  path          :string           not null
#  primary_phone :string
#  query         :string           not null
#  referrer      :string           not null
#  ssn           :string
#  state         :string
#  tcpa_consent  :boolean
#  tcpa_language :text
#  user_agent    :string           not null
#  work_phone    :string
#  zip           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  jornaya_id    :string
#
class LeadInternalFieldsBlueprint < Blueprinter::Base
  fields *Lead::INTERNAL_FIELDS
end

class LeadUserFieldsBlueprint < Blueprinter::Base
  fields *Lead::USER_FIELDS
end

class LeadBlueprint < Blueprinter::Base
  identifier :id

  field :internal_fields do |lead|
    LeadInternalFieldsBlueprint.render_as_hash(lead)
  end

  field :user_fields do |lead|
    LeadUserFieldsBlueprint.render_as_hash(lead)
  end
end
