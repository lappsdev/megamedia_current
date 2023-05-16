class SshCommandResource < ApplicationResource
  self.adapter = Graphiti::Adapters::Null
  attribute :command, :string
  attribute :output, :string

  polymorphic_belongs_to :ssh_runner do
    group_by(:ssh_runner_type) do
      on(:Device)
    end
  end

  def create(attrs)
    SshCommand.create(attrs).tap do |ssh|
      ssh.execute
    end
  end
end
