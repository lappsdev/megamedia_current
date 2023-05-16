class PasswordCallerWidget < Widget
  include AttrJson::Record
  attr_json_config(default_container_attribute: :data)
end
