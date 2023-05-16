class ProductResource < ApplicationResource
  self.adapter = Graphiti::Adapters::Null
  attribute :description, :string
  attribute :price, :float
  attribute :promotional_price, :float
  attribute :fator_promotional_price, :float
  attribute :fator_promotional, :float
  attribute :balance_code, :string

  filter :requester_id, :integer, only: [:eq], required: true do
    eq do |scope, value|
      scope[:filters][:requester_id] = value
      scope
    end
  end
  filter :requester_type, :string, only: [:eq], required: true do
    eq do |scope, value|
      scope[:filters][:requester_type] = value
      scope
    end
  end
  filter :barcode, :string, only: [:eq] do
    eq do |scope, value|
      scope[:filters][:barcode] = value
      scope
    end
  end
  def base_scope(*)
    { sort: {}, filters: {} }
  end

  def resolve(scope)
    data = []
    filters = scope[:filters]
    if filters.present?
      if filters[:requester_type][0] == 'PriceCheckerWidget'
        requester = filters[:requester_type][0].constantize.find(filters[:requester_id][0])
        product = requester.find_product(barcode: filters[:barcode][0])
        data << product if product
      elsif filters[:requester_type][0] == 'ProductTableWidget'
        requester = filters[:requester_type][0].constantize.find(filters[:requester_id][0])
        products = requester.products
        data = products if products
      end
    end
    data
  end
end
