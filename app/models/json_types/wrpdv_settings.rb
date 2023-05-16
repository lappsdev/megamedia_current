module JsonTypes
  class WrpdvSettings
    include AttrJson::Model

    attr_json :pdvlivre_path, :string
  end
end
