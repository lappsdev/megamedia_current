class UnitResource < ApplicationResource
  attribute :name, :string
  attribute :wrpdv_settings, :wrpdv_settings
  attribute :flex_settings, :flex_settings

  attribute :notes, :string

  has_many :devices
  filter :group_id, :integer

  belongs_to :group
end
