require 'spec_helper'

describe Conversation do
  it "creates a valid conversation" do
    FactoryGirl.build(:conversation).should be_valid
  end

  it "can be found via user_ids" do
    conversation = FactoryGirl.create(:conversation)
    sender = conversation.sender
    recipient = conversation.recipient

    Conversation.find_by_user_ids(sender.id, recipient.id).should == conversation
  end

  it "can be found via reversed user_ids" do
    conversation = FactoryGirl.create(:conversation)
    sender = conversation.sender
    recipient = conversation.recipient
    Conversation.find_by_user_ids(recipient.id, sender.id).should == conversation
  end

  it "only allows one conversation to be created between two users" do
    u1 = FactoryGirl.create(:user)
    u2 = FactoryGirl.create(:user)
    conversation1 = Conversation.create(:sender_id => u1.id, :recipient_id => u2.id)
    conversation2 = Conversation.new(:sender_id => u1.id, :recipient_id => u2.id)
    conversation3 = Conversation.new(:sender_id => u2.id, :recipient_id => u1.id)
    conversation2.should_not be_valid
    conversation3.should_not be_valid
  end

  it "returns the correct participants" do
    conversation = FactoryGirl.create(:conversation)
    u1 = conversation.sender
    u2 = conversation.recipient
    conversation.participants.should include(u1,u2)
  end

  it "returns the other user" do
    conversation = FactoryGirl.create(:conversation)
    conversation.other_user(conversation.sender).should == conversation.recipient
  end

  it "finds or creates by two user ids" do
    u1 = FactoryGirl.create(:user)
    u2 = FactoryGirl.create(:user)
    c = Conversation.find_or_create_by_user_ids(u1.id, u2.id)
    c2 = Conversation.find_or_create_by_user_ids(u1.id, u2.id)
    c.should == c2
    c.id.should == c2.id
  end
end
