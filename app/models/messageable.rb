class Messageable < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :sender, :class_name => "User"
  accepts_nested_attributes_for :conversation
  
  validates_presence_of :body
  validates_presence_of :conversation

  def self.prepare_messageable(sender_id, recipient_id)
    conversation = Conversation.find_or_create_by_user_ids(sender_id, recipient_id)
    messageable = conversation.messageables.build(:sender_id => sender_id)
  end


end

