# == Schema Information
#
# Table name: leads
#
#  id            :uuid             not null, primary key
#  address       :string
#  address2      :string
#  city          :string
#  country       :string
#  date_of_birth :string
#  email         :string
#  fcra_language :string
#  first_name    :string
#  host          :string           not null
#  ip_address    :string           not null
#  last_name     :string
#  loan_amount   :string
#  meta_fields   :jsonb
#  path          :string           not null
#  phone         :string
#  query         :jsonb            not null
#  referrer      :string
#  ssn           :string
#  state         :string
#  tcpa_language :string
#  txid          :string
#  user_agent    :string
#  work_phone    :string
#  zip           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  jornaya_id    :string
#
class Lead < ApplicationRecord
  has_many :request_logs
  has_many :stack_results

  INTERNAL_FIELDS = %w[
    txid
    jornaya_id
  ].freeze

  USER_FIELDS = %w[
    first_name
    last_name
    email
    phone
    work_phone
    address
    address2
    city
    state
    zip
    country
    date_of_birth
  ].freeze

  def assign_fields!(fields, whitelist)
    fields ||= {}
    unpermitted = fields.keys - whitelist
    raise ActionController::UnpermittedParameters.new(unpermitted) if unpermitted.present?

    fields.each do |field, value|
      self[field] = value
    end
  end

  def evaluate_meta_fields(meta_fields)
    # probably create a new service that just handles all these
    # these are all the derivation fields like...
    #
    # { purpose_with_amount: "debt_consolidation:20000" | "" }
    #   -> loan_purpose: debt_consolidation
    #   -> loan_amount: 20_000
  end
end
