class Device < ApplicationRecord
  include AttrJson::Record
  attr_json_config(default_container_attribute: :data)
  validates_presence_of :name
  has_one :screen, dependent: :destroy
  belongs_to :unit
  attr_json :ssh_settings, JsonTypes::SshSettings.to_type, default: {}

  def execute_ssh
    if ssh_settings && ssh_settings.host
      Net::SSH.start(ssh_settings.host, ssh_settings.user, password: ssh_settings.password) do |ssh|
        ssh.exec!(command)
      end
    end
  end
end
