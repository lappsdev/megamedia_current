class Device < ApplicationRecord
  include AttrJson::Record
  attr_json_config(default_container_attribute: :data)
  validates_presence_of :name
  has_one :screen, dependent: :destroy
  belongs_to :unit
  belongs_to :department, optional: true
  attr_json :ssh_settings, JsonTypes::SshSettings.to_type, default: {}
  validate :validate_department_from_unit
  def execute_ssh
    return unless ssh_settings && ssh_settings.host

    Net::SSH.start(ssh_settings.host, ssh_settings.user, password: ssh_settings.password) do |ssh|
      ssh.exec!(command)
    end
  end

  private

  def validate_department_from_unit
    return if department.nil?
    return if unit.departments.exists?(id: department.id)

    errors.add(:department,
               'O departamento precisa fazer parte da mesma unidade que o equipamento se encontra')
  end
end
