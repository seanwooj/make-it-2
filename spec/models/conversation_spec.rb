require 'spec_helper'

describe Conversation do
  it "creates a valid conversation" do
    FactoryGirl.build(:conversation).should be_valid
  end

  it "can be found via user_ids" do
    conversation = FactoryGirl.create(:conversation)
    sender = conversation.sender
    recipient = conversation.recipient

    Conversation.find_by_users(sender.id, recipient.id).should == conversation
  end

  it "can be found via reversed user_ids" do
    conversation = FactoryGirl.create(:conversation)
    sender = conversation.sender
    recipient = conversation.recipient
    Conversation.find_by_users(recipient.id, sender.id).should == conversation
  end

  it "should only allow one conversation to be created between two users" do
    conversation1 = Conversation.create(:sender_id => 1, :recipient_id => 2)
    conversation2 = Conversation.new(:sender_id => 1, :recipient_id => 2)
    conversation3 = Conversation.new(:sender_id => 2, :recipient_id => 1)
    conversation2.should_not be_valid
    conversation3.should_not be_valid
  end

  it "should return the correct participants" do
    conversation = FactoryGirl.create(:conversation)
    u1 = conversation.sender
    u2 = conversation.recipient
    conversation.participants.should include(u1,u2)
  end
end
