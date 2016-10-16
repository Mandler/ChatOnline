class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform
    ActionCable.server.broadcast 'NotificationChannel', 'Message'
  end
end
