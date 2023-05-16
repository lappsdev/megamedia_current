module Schedulable
  extend ActiveSupport::Concern
  included do
    has_one :scheduler, as: :schedulable

    accepts_nested_attributes_for :scheduler, allow_destroy: true

    after_initialize do |model|
      model.scheduler = Scheduler.create(schedulable: model) if model.persisted? && model.scheduler.nil?
    end
  end
end
