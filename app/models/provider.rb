# == Schema Information
#
# Table name: providers
#
#  id   :bigint           not null, primary key
#  name :string           not null
#
class Provider < ApplicationRecord
  has_many :request_logs
end
