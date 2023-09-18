class PasswordCallerWidgetResource < WidgetResource
  belongs_to :department
  attribute :department_id, :integer
end
