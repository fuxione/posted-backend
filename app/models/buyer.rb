# == Schema Information
#
# Table name: buyers
#
#  id                  :bigint           not null, primary key
#  daily_cap           :integer          default(-1), not null
#  enabled             :boolean          default(TRUE), not null
#  everflow_oid        :string
#  exclude_conditions  :jsonb
#  include_conditions  :jsonb
#  name                :string           not null
#  payout_event        :string
#  price               :decimal(, )      default(0.0), not null
#  representative_name :string           default(""), not null
#  ringba_phone        :string
#  ringba_url          :string
#
class Buyer < ApplicationRecord
  has_many :request_logs
end
