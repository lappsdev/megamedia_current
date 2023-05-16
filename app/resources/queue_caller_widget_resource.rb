class QueueCallerWidgetResource < WidgetResource
  include AttachableResource

  attribute :pdvs_to_check, :array_of_strings
  attribute :pdvlivre_path, :string
  attribute :samba_settings, :samba_settings
  extra_attribute :queue, :array
end
