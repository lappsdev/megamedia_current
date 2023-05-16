module JsonTypes
  class SambaSettings
    include AttrJson::Model

    attr_json :domain, :string, default: 'WORKGROUP'
    attr_json :host, :string, default: ''
    attr_json :share, :string, default: ''
    attr_json :user, :string, default: 'guest'
    attr_json :password, :string, default: '--no-pass'
    attr_json :port, :integer, default: 445

    attr_json :path_to_cd, :string

    def samba_connection
      client = Sambal::Client.new(domain: domain,
                                  host: host,
                                  share: share,
                                  user: user,
                                  pass: password,
                                  port: port)
      client.cd(path_to_cd) if path_to_cd
      client
    end
  end
end
