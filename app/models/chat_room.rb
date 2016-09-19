class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :messages, dependent: :destroy

  scope :find_title, ->(title) { joins(:user).where("title LIKE ?", "%#{title}%") }
  scope :created_by, ->(email) { joins(:user).where("users.email LIKE ?", "%#{email}%") }

  scope :find_by_title_or_author, ->(search_text) { find_title(search_text).or(created_by(search_text)) }
end
