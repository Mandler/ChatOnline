class CreateChatRooms < ActiveRecord::Migration[5.0]
  def change
    create_table :chat_rooms do |t|
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps
    end

    add_index :conversations, :sender_id
    add_index :conversations, :recipient_id
  end
end
