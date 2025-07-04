# == Schema Information
#
# Table name: stack_results
#
#  id                  :bigint           not null, primary key
#  final_price         :decimal(10, 2)   not null
#  final_response_body :string           not null
#  offer_type          :string           not null
#  stack_snapshot      :jsonb            not null
#  status              :string           not null
#  won_at              :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  buyer_id            :bigint           not null
#  buyers_stack_id     :bigint           not null
#  lead_id             :uuid             not null
#  request_log_id      :bigint           not null
#
# Indexes
#
#  index_stack_results_on_buyer_id         (buyer_id)
#  index_stack_results_on_buyers_stack_id  (buyers_stack_id)
#  index_stack_results_on_lead_id          (lead_id)
#  index_stack_results_on_request_log_id   (request_log_id)
#
# Foreign Keys
#
#  fk_rails_...  (buyer_id => buyers.id)
#  fk_rails_...  (buyers_stack_id => buyers_stacks.id)
#  fk_rails_...  (lead_id => leads.id)
#  fk_rails_...  (request_log_id => request_logs.id)
#
class StackResult < ApplicationRecord
  belongs_to :lead
  has_one :request_log
end
