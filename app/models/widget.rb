class Widget < ApplicationRecord
  include AttrJson::Record
  attr_json_config(default_container_attribute: :data)
  validates_presence_of :name
  belongs_to :screen

  def unit
    screen&.device&.unit
  end
end
