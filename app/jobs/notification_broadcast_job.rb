class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform
    ActionCable.server.broadcast_to 'NotificationChannel', 'Message'
  end
end
