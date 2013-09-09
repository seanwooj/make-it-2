class Messageable < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :sender, :class_name => "User"
  accepts_nested_attributes_for :conversation
  
  validates_presence_of :body
  validates_presence_of :conversation

  def find_or_create_conversation

  end

end

