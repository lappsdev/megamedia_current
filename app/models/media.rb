class Media < ApplicationRecord
  belongs_to :attachment
  belongs_to :attachable, polymorphic: true
  has_one :scheduler, as: :schedulable
end
