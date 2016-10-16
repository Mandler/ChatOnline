class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from "notification_channel_#{params['current_user_id']}"
  end
end
