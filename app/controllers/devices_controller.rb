class DevicesController < ApplicationController
  before_action :set_device, only: %i[show edit update destroy]

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
    respond_to do |format|
      format.html {}
      format.jsonapi do
        device = DeviceResource.find(params)
        respond_with(device)
      end
    end
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
    respond_to do |format|
      format.html do
        if @device.update(device_params)
          redirect_to device_url(@device), notice: 'Equipameno atualizado com sucesso.'
        else
          render :edit, status: :unprocessable_entity
        end
      end
      format.jsonapi do
        device = DeviceResource.find(params)

        if device.update_attributes
          render jsonapi: device
        else
          render jsonapi_errors: device
        end
      end
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

  def set_device
    @device = Device.find(params[:id])
  end

  def device_params
    params.require(:device).permit!
  end

  def get_unit
    @unit = Unit.find_by_id(params[:unit_id])
  end
end
