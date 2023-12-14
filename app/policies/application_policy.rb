# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @device = user if user.is_a?(Device)
      @scope = scope
    end

    def resolve
      if user.is_a?(Device)
        resolve_for_device
      else
        resolve_for_user
      end
    end

    def resolve_for_user
      raise NotImplementedError, "You must define #resolve_for_user in #{self.class}"
    end

    def resolve_for_device
      raise NotImplementedError, "You must define #resolve_for_device in #{self.class}"
    end

    private

    attr_reader :user, :scope, :device
  end
end
