class ProductTableWidget < Widget
  attr_json :product_codes, :string, array: true, default: []
  attr_json :flex_settings, JsonTypes::FlexSettings.to_type, default: {}
  def products
    Product.find_all_by_balance_codes(balance_codes: product_codes, unit_code: flex_data.unit_code, connection: flex_connection)
  end

  def flex_connection
    flex_data.postgres_connection
  end

  def flex_data
    has_flex_settings? ? flex_settings : unit&.flex_settings
  end

  def has_flex_settings?
    flex_settings && flex_settings.attributes.values.compact.length == 6
  end
end
