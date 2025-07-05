# == Schema Information
#
# Table name: leads
#
#  id                       :uuid             not null, primary key
#  address                  :string
#  address2                 :string
#  city                     :string
#  country                  :string
#  credit_score             :string
#  date_of_birth            :string
#  debt_amount              :string
#  email                    :string
#  employment_pay_frequency :string
#  employment_status        :string
#  fcra_language            :string
#  first_name               :string
#  host                     :string           not null
#  ip_address               :string           not null
#  last_name                :string
#  loan_amount              :string
#  meta_fields              :jsonb
#  monthly_income           :string
#  path                     :string           not null
#  phone                    :string
#  query                    :jsonb            not null
#  referrer                 :string
#  ssn                      :string
#  state                    :string
#  tcpa_language            :string
#  txid                     :string
#  user_agent               :string
#  vertical                 :string           not null
#  wid                      :integer          not null
#  work_phone               :string
#  zip                      :string
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  jornaya_id               :string
#
class Lead < ApplicationRecord
  FIELDS = %w[
    txid
    jornaya_id
    tcpa_language
    fcra_language
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
    ssn
    credit_score
    loan_amount
    debt_amount
    monthly_income
  ].freeze

  VERTICALS = %w[
    debt
    personal_loan
    business_loan
  ]

  EMPLOYMENT_STATUS = %w[
    employed
    employed_full_time
    employed_part_time
    military
    not_employed
    self_employed
    retired
    other
  ]

  EMPLOYMENT_PAY_FREQUENCY = %w[
    weekly
    biweekly
    twice_monthly
    monthly
  ]

  has_many :request_logs
  has_many :stack_results

  # request
  validates :host,       presence: true
  validates :path,       presence: true
  validates :ip_address, presence: true

  # user: profile
  validates :first_name,    presence: true, allow_nil: true
  validates :last_name,     presence: true, allow_nil: true
  validates :email,         presence: true, allow_nil: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
  validates :phone,         presence: true, allow_nil: true, phone: true
  validates :work_phone,    presence: true, allow_nil: true, phone: true
  validates :address,       presence: true, allow_nil: true
  validates :city,          presence: true, allow_nil: true
  validates :state,         presence: true, allow_nil: true, inclusion: { in: ISO3166::Country["US"].subdivisions.keys, message: "must be a valid ISO 3166-2 US state code" }
  validates :zip,           presence: true, allow_nil: true, format: { with: /\A\d{5}(-\d{4})?\z/, message: "must be in the format of 12345 or 12345-6789" }
  validates :country,       presence: true, allow_nil: true, inclusion: { in: [ "US" ] }
  validates :date_of_birth, presence: true, allow_nil: true, date_of_birth: true
  validates :ssn,           presence: true, allow_nil: true, format: { with: /\A\d{3}-\d{2}-\d{4}\z/, message: "must be in the format of XXX-XX-XXXX" }

  # user: loan
  validates :loan_amount,              presence: true, allow_nil: true, range_amount: { currency: true }
  validates :debt_amount,              presence: true, allow_nil: true, range_amount: { currency: true }
  validates :monthly_income,           presence: true, allow_nil: true, range_amount: { currency: true }
  validates :employment_status,        presence: true, allow_nil: true, inclusion: { in: EMPLOYMENT_STATUS, message: "must be a valid employment status" }
  validates :employment_pay_frequency, presence: true, allow_nil: true, inclusion: { in: EMPLOYMENT_PAY_FREQUENCY, message: "must be a valid pay frequency" }
  validates :credit_score,             presence: true, allow_nil: true, range_amount: { currency: false }

  # internal
  validates :wid,           presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :vertical,      presence: true, inclusion: { in: VERTICALS, message: "must be a valid vertical" }
  validates :txid,          presence: true, allow_nil: true
  validates :jornaya_id,    presence: true, allow_nil: true
  validates :tcpa_language, presence: true, allow_nil: true
  validates :fcra_language, presence: true, allow_nil: true

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
