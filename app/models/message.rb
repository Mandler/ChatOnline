class Message < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  validates_presence_of :body, :chat_room_id, :user_id

  after_create_commit { MessageBroadcastJob.perform_later(self) }

  def timestamp
    created_at.strftime('%H:%M:%S %d %B %Y')
  end
end
