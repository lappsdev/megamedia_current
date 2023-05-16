class ApplicationResource < Graphiti::Resource
  self.abstract_class = true

  # We'll be using ActiveRecord
  self.adapter = Graphiti::Adapters::ActiveRecord

  # Links are generated from base_url + endpoint_namespace
  self.base_url = Rails.application.routes
                       .default_url_options[:host]
  self.endpoint_namespace = '/api/v1'
end

JsonTypes.all_modules.reject { |el| el == JsonTypes }.each do |el|
  symbol = el.name.sub('JsonTypes::', '').sub('::', '_').tableize.to_sym
  Graphiti::Types[symbol] = {
    params: Dry::Types::Nominal.new(el),
    read: Dry::Types::Nominal.new(el),
    write: Dry::Types::Nominal.new(el),
    kind: 'scalar',
    canonical_name: symbol,
    description: 'Mano'
  }
end
