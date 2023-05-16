class WidgetResource < ApplicationResource
  self.polymorphic = %w[ImageWidgetResource VideoWidgetResource PriceCheckerWidgetResource WidgetResource QueueCallerWidgetResource ProductTableWidgetResource PasswordCallerWidgetResource]
  attribute :name, :string
  attribute :description, :string

  attribute :x, :integer
  attribute :y, :integer
  attribute :width, :integer
  attribute :height, :integer

  attribute :type, :string

  filter :screen_id, :integer
  belongs_to :screen
end
