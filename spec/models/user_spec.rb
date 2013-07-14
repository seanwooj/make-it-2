require 'spec_helper'

describe User do
  subject(:valid_user) { User.new(
      email: "boop@bleep.com",
      full_name: "bleep bloop",
      has_machine: false
  ) }

  # TODO - not sure if this is the best way to mock an association.
  let!(:location) { valid_user.locations.build(
      address_1: "86 Lessay",
      address_2: "Upstairs Bedroom",
      city: "Newport Coast",
      state: "California",
      zipcode: "92657",
      country: "United States of America",
      user_id: 1
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

  # TODO - this is brittle as fuck
  it "should have many locations" do
    valid_user.locations.should_not be_nil
  end
end
