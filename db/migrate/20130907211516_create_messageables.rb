class CreateMessageables < ActiveRecord::Migration
  def change
    create_table :messageables do |t|
      t.timestamps
      t.integer :conversation_id
      t.integer :sender_id
      t.text :body
    end
  end
end

