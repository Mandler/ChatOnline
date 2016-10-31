class User < ApplicationRecord
    has_many :chat_rooms, foreign_key: :sender_id
    has_many :messages
    devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

    def nick
        name.to_s == '' ? email.split('@')[0] : name
    end
end
