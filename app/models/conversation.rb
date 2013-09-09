class Conversation < ActiveRecord::Base
  has_many :user_conversations, :dependent => :destroy
  has_many :users, :through => :user_conversations
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  belongs_to :recipient, :class_name => "User", :foreign_key => "recipient_id"
  validate :does_not_exist_already?

  def self.find_by_users(sender_id, recipient_id)
    # inefficient
    attempt_1 = Conversation.where(:sender_id => sender_id, :recipient_id => recipient_id)
    conversation =
        if attempt_1.length > 0
          attempt_1
        else
          Conversation.where(:sender_id => recipient_id, :recipient_id => sender_id)
        end
    # presumably there will only be one conversation between two users
    # if nothing xocmes up in attempt 2, conversation.first will be nil
    conversation.first
  end

  def participants
    [sender, recipient]
  end

  private

  def create_user_conversations

  end

  def does_not_exist_already?
    if Conversation.find_by_users(self.recipient_id, self.sender_id).nil?
      return true
    else
      errors.add(:conversation, "already exists!")
      return false
    end
  end

end

