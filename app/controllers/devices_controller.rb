class DevicesController < ApplicationController
  before_action :get_unit

  def index
    respond_to do |format|
      format.html { @devices ||= Current.user.group.devices }
      format.jsonapi do
        devices = DeviceResource.all(params)
        respond_with(devices)
      end
    end
  end

  def new
    @device = @unit&.devices&.build || Device.new
  end

  def show
    device = DeviceResource.find(params)
    respond_with(device)
  end

  def create
    @device = @unit&.devices&.build(device_params) || Device.new(device_params)

    respond_to do |format|
      format.html do
        if @device.save
          redirect_to devices_url,
                      notice: 'Equipamento cadastrado com sucesso.'
        else
          flash.now[:alert] = 'Erro ao cadastrar!'
          render :new, status: :unprocessable_entity
        end
      end

      format.jsonapi do
        device = DeviceResource.build(params)

        if device.save
          render jsonapi: device, status: 201
        else
          render jsonapi_errors: device
        end
      end
    end
  end

  def update
    device = DeviceResource.find(params)

    if device.update_attributes
      render jsonapi: device
    else
      render jsonapi_errors: device
    end
  end

  def destroy
    device = DeviceResource.find(params)

    if device.destroy
      render jsonapi: { meta: {} }, status: 200
    else
      render jsonapi_errors: device
    end
  end

  private

  def device_params
    params.require(:device).permit!
  end

  def get_unit
    @unit = Unit.find_by_id(params[:unit_id])
  end
end
