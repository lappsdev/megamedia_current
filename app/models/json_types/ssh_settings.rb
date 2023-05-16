module JsonTypes
  class SshSettings
    include AttrJson::Model

    attr_json :host, :string
    attr_json :port, :integer, default: 22
    attr_json :user, :string
    attr_json :password, :string

    def connection
      Net::SSH.start(host, user, password: password)
    end
  end
end
