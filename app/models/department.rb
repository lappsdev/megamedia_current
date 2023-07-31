class Department < ApplicationRecord
  belongs_to :unit
  validates_presence_of :name
end
