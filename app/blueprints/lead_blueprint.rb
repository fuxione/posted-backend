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
class LeadAttributeBlueprint < Blueprinter::Base
  fields :txid, :jornaya_id
end

class LeadFieldBlueprint < Blueprinter::Base
  fields :first_name,
    :last_name,
    :email,
    :phone,
    :work_phone,
    :address,
    :address2,
    :city,
    :state,
    :zip,
    :country,
    :date_of_birth
end

class LeadBlueprint < Blueprinter::Base
  identifier :id

  field :fields do |lead|
    LeadFieldBlueprint.render_as_hash(lead)
  end

  field :attributes do |lead|
    LeadAttributeBlueprint.render_as_hash(lead)
  end
end
