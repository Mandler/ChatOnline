class ChatRoom < ApplicationRecord
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, :scope => :recipient_id

  def self.involving(user)
    where("sender_id = ? OR recipient_id = ?", user.id, user.id)
  end

  def self.between(sender_id, recipient_id)
    where("(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)", sender_id, recipient_id, recipient_id, sender_id)
  end

  # scope :find_by_title, ->(title) { joins(:user).where("title LIKE ?", "%#{title}%") }
  # scope :created_by, ->(email) { joins(:user).where("users.email LIKE ?", "%#{email}%") }

  # scope :find_by_person, ->(id) { where("chat_rooms.user_id = #{id}") }
  # scope :find_by_person_messages, ->(id) { joins(:messages).where("messages.user_id = #{id}") }

  # scope :find_by_current_user, ->(current_user_id) { (find_by_person(current_user_id) + find_by_person_messages(current_user_id)).uniq }

  # scope :find_by_title_or_author, ->(search_text) { find_by_title(search_text).or(created_by(search_text)) }
end
