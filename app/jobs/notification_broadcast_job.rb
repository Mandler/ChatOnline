class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(send_to, sender_id)
    ActionCable.server.broadcast "notification_channel_#{send_to}",
                                  send_to: send_to,
                                  sender_id: sender_id
  end
end
