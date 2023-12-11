class PriceCheckerWidget < Widget
  include AttrJson::Record
  attr_json_config(default_container_attribute: :data)

  attr_json :flex_settings, JsonTypes::FlexSettings.to_type, default: {}
  attr_json :idle_text, :string, default: 'Passe o código de barras no leitor'

  has_one :media, as: :attachable, dependent: :delete
  has_one :attachment, through: :media
  has_many :price_checks
  def find_product(barcode:)
    if use_rp_info_api?
      unit.rp_info_api.get_product_by_barcode(barcode)
    else
      Product.find_by_barcode(barcode, connection: flex_connection, unit_code: flex_data.unit_code)
    end
  end

  def flex_connection
    flex_data.postgres_connection
  end

  def flex_data
    has_flex_settings? ? flex_settings : unit&.flex_settings
  end

  def use_rp_info_api?
    false
  end

  def has_flex_settings?
    flex_settings && flex_settings.attributes.values.compact.length == 6
  end
end
