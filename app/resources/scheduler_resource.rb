class SchedulerResource < ApplicationResource
  attribute :started_at, :datetime
  attribute :finished_at, :datetime

  polymorphic_belongs_to :schedulable do
    group_by(:schedulable_type) do
      on(:ImageWidget)
      on(:VideoWidget)
      on(:Attachment)
    end
  end

  filter :schedulable_type, :string
  filter :schedulable_id, :integer
end
