class Group < ApplicationRecord
  validates_presence_of :name
  has_many :users
  has_many :units
  has_many :devices, through: :units
  has_many :screens
  has_many :attachments
  store_accessor :json_attributes, :use_rp_info_api, :rp_info_api_user, :rp_info_api_password, :rp_info_api_endpoint

  def rp_info_api
    unit_sample = units.all.find { |unit| unit.cnpj.present? }
    unit_sample&.rp_info_api
  end

  def can_connect_rp_info_api?
    rp_info_api.authenticate
  rescue StandardError => e
    p e.backtrace
    false
  end
end
