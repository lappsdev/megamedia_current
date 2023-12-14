class ScreenResource < ApplicationResource
  attribute :name, :string
  has_many :widgets

  belongs_to :device
  belongs_to :group
  filter :device_id, :integer
  filter :group_id, :integer

  def base_scope
    Pundit.policy_scope(context.pundit_user, Screen)
  end
end
