class UserResource < ApplicationResource
  attribute :login, :string
  attribute :name, :string
  attribute :password, :string
  attribute :role, :string_enum, allow: User.roles.keys
  belongs_to :group
  filter :group_id, :integer
end
