class RebootAllDevicesWorker
  include Sidekiq::Worker

  def perform
    Device.all.each do |device|
      device.execute_ssh('sudo reboot')
    end
  end
end
