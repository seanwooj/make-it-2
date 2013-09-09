require 'spec_helper'

describe Messageable do
  subject(:messageable) do
    Messageable.prepare_messageable(FactoryGirl.create(:user).id, FactoryGirl.create(:user).id)
  end

  it "saves correctly" do
    messageable.body = "boooppy boop"
    messageable.save!
  end

  it "saves when a conversation already exists" do
    u1 = FactoryGirl.create(:user)
    u2 = FactoryGirl.create(:user)
    conversation = Conversation.create(:sender_id => u1.id, :recipient_id => u2.id)
    message = Messageable.prepare_messageable(u1.id, u2.id)
    message.body = "exists!"
    message.save!
  end
end
