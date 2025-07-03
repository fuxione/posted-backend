# == Schema Information
#
# Table name: request_logs
#
#  id            :bigint           not null, primary key
#  metadata      :jsonb            not null
#  method        :string           not null
#  request_body  :text             not null
#  response_body :text             not null
#  status_code   :integer          not null
#  success       :boolean          not null
#  total_time    :decimal(10, 3)   not null
#  url           :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  buyer_id      :bigint
#  lead_id       :uuid             not null
#  provider_id   :bigint
#
# Indexes
#
#  index_request_logs_on_buyer_id     (buyer_id)
#  index_request_logs_on_lead_id      (lead_id)
#  index_request_logs_on_provider_id  (provider_id)
#
# Foreign Keys
#
#  fk_rails_...  (buyer_id => buyers.id)
#  fk_rails_...  (lead_id => leads.id)
#  fk_rails_...  (provider_id => providers.id)
#
class RequestLog < ApplicationRecord
  belongs_to :lead
  belongs_to :provider, optional: true
  belongs_to :buyer, optional: true
end
