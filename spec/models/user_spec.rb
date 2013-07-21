require 'spec_helper'

describe User do
  subject(:valid_user) { User.new(
      email: "boop@bleep.com",
      full_name: "bleep bloop",
      password: "password",
      has_machine: false
  ) }

  # TODO - not sure if this is the best way to mock an association.
  let!(:location) { valid_user.locations.build(
      address: "86 Lessay, Newport Coast, CA 92657, USA",
      address_2: "Upstairs Bedroom"
  )}

  it "should be a valid user" do
    valid_user.should be_valid
  end

  it "should be invalid with no email" do
    valid_user.email = nil
    valid_user.should_not be_valid
  end

  it "should be invalid with an badly formatted emails" do
    bad_emails = %w[test@test test@test+test.com test@test@test.com]
    bad_emails.each do |email|
      valid_user.email = email
      valid_user.should_not be_valid
    end
  end

  it "should be valid with well formatted emails" do
    good_emails = %w[test@test.com test+test@test.com test@test.jp test@test.co.uk]
    good_emails.each do |email|
      valid_user.email = email
      valid_user.should be_valid
    end
  end

  it "should be invalid with no full_name" do
    valid_user.full_name = nil
    valid_user.should_not be_valid
  end

  it { should have_many(:locations) }
  it { should have_many(:machines) }

  context "locations" do
    it "has a primary location set" do
      valid_user.primary_location.should == location
    end
  end
end
