# == Schema Information
#
# Table name: buyers_stacks
#
#  id          :bigint           not null, primary key
#  config      :jsonb            not null
#  description :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class BuyersStack < ApplicationRecord
end
