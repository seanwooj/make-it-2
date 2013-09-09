class Conversation < ActiveRecord::Base
  has_many :user_conversations, :dependent => :destroy
  has_many :users, :through => :user_conversations
  has_many :messageables
  belongs_to :sender, :class_name => "User", :foreign_key => "sender_id"
  belongs_to :recipient, :class_name => "User", :foreign_key => "recipient_id"
  accepts_nested_attributes_for :user_conversations
  validate :does_not_exist_already?

  after_validation :create_user_conversations

  def self.find_by_user_ids(sender_id, recipient_id)
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

  def self.find_or_create_by_user_ids(recipient_id, sender_id)
    conversation = Conversation.find_by_user_ids(recipient_id, sender_id)
    unless conversation.nil?
      conversation
    else
      Conversation.create(:sender_id => sender_id, :recipient_id => recipient_id)
    end
  end

  def participants
    [sender, recipient]
  end

  def other_user(current_user)
    (participants - [current_user]).first
  end

  private

  def create_user_conversations
    participants.each do |participant|
      self.user_conversations.build(:user_id => participant.id)
    end
  end

  def does_not_exist_already?
    if Conversation.find_by_user_ids(self.recipient_id, self.sender_id).nil?
      return true
    else
      errors.add(:conversation, "already exists!")
      return false
    end
  end

end

