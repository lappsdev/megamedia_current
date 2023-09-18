class DepartmentResource < ApplicationResource
  attribute :name, :string
  attribute :queue_index, :string

  attribute :unit_id, :integer
  belongs_to :unit
end
