class NotificationChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'NotificationChannel'
  end
end
