class DeviceResource < ApplicationResource
  attribute :name, :string
  attribute :ip, :string
  attribute :mac, :string
  attribute :notes, :string
  filter :unit_id, :integer
  belongs_to :unit
  has_one :screen

  attribute :ssh_settings, :ssh_settings

  sort :unit, :string do |scope, direction|
    scope.includes(:unit).order("units.name #{direction}")
  end
end
