class User < ApplicationRecord
  has_many :chat_rooms, foreign_key: :sender_id
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  def nick
    self.name.to_s == '' ? email.split('@')[0] : self.name
  end
end
