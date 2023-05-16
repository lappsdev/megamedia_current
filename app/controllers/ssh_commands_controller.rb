class SshCommandsController < ApplicationController
  def index
    ssh_commands = SshCommandResource.all(params)
    respond_with(ssh_commands)
  end

  def show
    ssh_command = SshCommandResource.find(params)
    respond_with(ssh_command)
  end

  def create
    ssh_command = SshCommandResource.build(params)

    if ssh_command.save
      render jsonapi: ssh_command, status: 201
    else
      render jsonapi_errors: ssh_command
    end
  end

  def update
    ssh_command = SshCommandResource.find(params)

    if ssh_command.update_attributes
      render jsonapi: ssh_command
    else
      render jsonapi_errors: ssh_command
    end
  end

  def destroy
    ssh_command = SshCommandResource.find(params)

    if ssh_command.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: ssh_command
    end
  end
end
