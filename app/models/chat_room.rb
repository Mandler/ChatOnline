class ChatRoom < ApplicationRecord
  extend FriendlyId
  belongs_to :user
  has_many :messages, dependent: :destroy

  friendly_id :title, use: :slugged

  scope :find_by_title, ->(title) { joins(:user).where("title LIKE ?", "%#{title}%") }
  scope :created_by, ->(email) { joins(:user).where("users.email LIKE ?", "%#{email}%") }

  scope :find_by_person, ->(id) { where("chat_rooms.user_id = #{id}") }
  scope :find_by_person_messages, ->(id) { joins(:messages).where("messages.user_id = #{id}") }

  scope :find_by_current_user, ->(current_user_id) { (find_by_person(current_user_id) + find_by_person_messages(current_user_id)).uniq }

  scope :find_by_title_or_author, ->(search_text) { find_by_title(search_text).or(created_by(search_text)) }
end
