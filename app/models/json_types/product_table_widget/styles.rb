module JsonTypes::ProductTableWidget
  class Styles
    include AttrJson::Model
    attr_json :rows_per_page, :integer, default: 10
  end
end
