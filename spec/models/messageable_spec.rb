require 'spec_helper'

describe Messageable do
  subject(:messageable) do
    Messageable.prepare_messageable(FactoryGirl.create(:user).id, FactoryGirl.create(:user).id)
  end

  it "saves correctly" do
    messageable.body = "boooppy boop"
    messageable.save!
  end
end
