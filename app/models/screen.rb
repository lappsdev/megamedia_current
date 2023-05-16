class Screen < ApplicationRecord
  validates_presence_of :name
  belongs_to :group
  belongs_to :device, optional: true
  has_many :widgets, dependent: :delete_all
end
