class GroupResource < ApplicationResource
  attribute :name, :string
  has_many :units
  has_many :users
end
