class DevicePolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve_for_user
      scope.joins(:unit).where(units: { group_id: user.group_id })
    end

    def resolve_for_device
      scope.where(id: device.id)
    end
  end
end
