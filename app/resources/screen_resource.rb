class ScreenResource < ApplicationResource
  attribute :name, :string
  has_many :widgets

  belongs_to :device
  belongs_to :group
  attribute :device_id, :integer
  attribute :group_id, :integer
end
