class Message < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  validates_presence_of :body, :chat_room_id, :user_id

  after_create_commit :all_performs

  def timestamp
    created_at.strftime('%H:%M:%S')
  end

  def all_performs
    recipient_id = self.chat_room.recipient_id
    sender_id = self.chat_room.sender_id
    send_from = self.user.id
    send_to = send_from == sender_id ? recipient_id : sender_id

    MessageBroadcastJob.perform_later(self)
    NotificationBroadcastJob.perform_later(send_to, send_from)
  end
end
