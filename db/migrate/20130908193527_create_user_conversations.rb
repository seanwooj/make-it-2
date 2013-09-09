class CreateUserConversations < ActiveRecord::Migration
  def change
    create_table :user_conversations do |t|
      t.integer :user_id
      t.integer :conversation_id
      t.boolean :is_unread, :default => true
      t.integer :last_read_messageable
      t.timestamps
    end
  end
end
