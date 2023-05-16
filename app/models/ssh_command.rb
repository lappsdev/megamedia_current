class SshCommand
  include ActiveModel::Model

  attr_accessor :command, :output, :ssh_runner, :ssh_runner_type, :ssh_runner_id

  class << self
    def create(attrs)
      p attrs
      if attrs[:command] && attrs[:ssh_runner_type] && attrs[:ssh_runner_id]
        new(attrs)
      else
        ssh_command.errors.add(:login, 'O login está incorreto.')
      end
    end
  end
  def ssh_runner
    ssh_runner_type.to_s.constantize.find(ssh_runner_id)
  end

  def execute
    Net::SSH.start(ssh_runner.ssh_settings.host, ssh_runner.ssh_settings.user, password: ssh_runner.ssh_settings.password) do |ssh|
      self.output = ssh.exec!(command)
    end
  end

  def id
    SecureRandom.random_number(101)
  end
end
