class Messageable < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :sender, :class_name => "User"
  
  validates_presence_of :body
  validates_presence_of :conversation
end

