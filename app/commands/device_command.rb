class DeviceCommand < TurboBoost::Commands::Command
  def search
    query = controller.params[:query]
    devices = Device.where('name ILIKE ? ', "%#{query}%")
    controller.instance_variable_set(:@devices, devices)
  end
end
