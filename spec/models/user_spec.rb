require 'spec_helper'

describe User do
  subject(:valid_user) { FactoryGirl.build(:user) }
  let!(:valid_owner) { FactoryGirl.build(:owner) }

  it "is a valid user" do
    valid_user.should be_valid
  end

  it "is invalid with no email" do
    valid_user.email = nil
    valid_user.should_not be_valid
  end

  it "is invalid with an badly formatted emails" do
    bad_emails = %w[test@test test@test+test.com test@test@test.com]
    bad_emails.each do |email|
      valid_user.email = email
      valid_user.should_not be_valid
    end
  end

  it "is valid with well formatted emails" do
    good_emails = %w[test@test.com test+test@test.com test@test.jp test@test.co.uk]
    good_emails.each do |email|
      valid_user.email = email
      valid_user.should be_valid
    end
  end

  it "is invalid with no full_name" do
    valid_user.full_name = nil
    valid_user.should_not be_valid
  end

  it { should have_many(:locations) }
  it { should have_many(:machines) }

  context "locations" do
    it "has a primary location set" do
      valid_user.primary_location.should == valid_user.locations[0]
    end
  end

end

