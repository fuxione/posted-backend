# == Schema Information
#
# Table name: clicks
#
#  id          :bigint           not null, primary key
#  current_url :string           not null
#  ip_address  :string           not null
#  next_url    :string           not null
#  referrer    :string           not null
#  user_agent  :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  lead_id     :uuid             not null
#
# Indexes
#
#  index_clicks_on_lead_id  (lead_id)
#
# Foreign Keys
#
#  fk_rails_...  (lead_id => leads.id)
#
class Click < ApplicationRecord
end
