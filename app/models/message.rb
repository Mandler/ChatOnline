class Message < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  validates_presence_of :body, :chat_room_id, :user_id

  after_create_commit :all_performs

  def timestamp
    created_at.strftime('%H:%M:%S')
  end

  def all_performs
    MessageBroadcastJob.perform_later(self)
    NotificationBroadcastJob.perform_later()
  end
end
