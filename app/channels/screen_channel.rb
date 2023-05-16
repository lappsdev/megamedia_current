class ScreenChannel < ApplicationCable::Channel
  def subscribed
    stream_for screen
  end

  def unsubscribed; end

  def edit(params)
    p params
    ScreenChannel.broadcast_to(screen, params)
  end

  def screen
    Screen.find(params[:id])
  end
end
