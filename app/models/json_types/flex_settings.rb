module JsonTypes
  class FlexSettings
    include AttrJson::Model

    attr_json :db_host, :string
    attr_json :db_port, :string
    attr_json :db_user, :string
    attr_json :db_password, :string
    attr_json :db_name, :string
    attr_json :unit_code, :string
    def postgres_connection
      PG.connect host: db_host,
                 port: db_port,
                 dbname: db_name,
                 user: db_user,
                 password: db_password
    end
  end
end
