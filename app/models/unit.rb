class Unit < ApplicationRecord
  include AttrJson::Record
  attr_json_config(default_container_attribute: :data)
  validates_presence_of :name
  attr_json :flex_settings, JsonTypes::FlexSettings.to_type, default: {}
  attr_json :wrpdv_settings, JsonTypes::WrpdvSettings.to_type, default: {}
  belongs_to :group
  has_many :devices
  has_many :departments
  store_accessor :json_attributes, :cnpj
  def flex_connection
    flex_settings.postgres_connection
  end

  def rp_info_api
    RpInfo::Api.new(unit: self)
  end
end
