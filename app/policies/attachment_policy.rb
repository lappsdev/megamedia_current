class AttachmentPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve_for_user
      scope.where(group_id: user.group_id)
    end

    def resolve_for_device
      scope.all
    end
  end
end
