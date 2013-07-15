require 'spec_helper'

describe "NewUserRegistrations" do
  describe "GET /new_user_registrations" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get new_user_registration_path
      response.status.should be(200)
    end
  end

  describe "google maps autocomplete" do
    it "creates the correct address when user signs up" do
      pending
      #user = FactoryGirl(:user)
      #visit new_user_registration_path
      #fill_in "Email", with => user.email
      #fill_in "Full name", with => user.full_name

    end
  end
end
