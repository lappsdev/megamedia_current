class UserCommand < TurboBoost::Commands::Command
  def search
    query = controller.params[:query]
    users = User.where('name ILIKE ? OR login ILIKE ?', "%#{query}%", "%#{query}%")
    controller.instance_variable_set(:@users, users)
  end
end
