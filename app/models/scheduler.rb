class Scheduler < ApplicationRecord
  belongs_to :schedulable, polymorphic: true
end
