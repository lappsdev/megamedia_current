class GroupPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve_for_user
      scope.where(id: user.group_id)
    end
  end
end
