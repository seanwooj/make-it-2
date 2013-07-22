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
    it "creates the correct address when user signs up", :js => true do
      user = FactoryGirl.build(:user)
      selector = '.pac-item:contains(\"port Beach\")'
      visit new_user_registration_path
      fill_in "Email", :with => user.email
      fill_in "Full name", :with => user.full_name
      fill_in "Password", :with => user.password
      fill_in "Password confirmation", :with => user.password
      fill_in "address", :with => "86 Lessay, New"
      sleep 1
      find('#address').native.send_keys :arrow_down
      find('#address').native.send_keys :return
      click_button "Sign up"
      page.should have_content "sign out"


    end

    it "does not create double resources when an error page is reached", :js => true do
      user = FactoryGirl.build(:user)
      visit new_user_registration_path
      fill_in "Email", :with => user.email
      fill_in "Full name", :with => user.full_name
      fill_in "Password", :with => user.password
      fill_in "address", :with => "86 Lessay, New"
      click_button "Sign up"
      # todo this is a kludge. fix later
      page.should_not have_css("#user_locations_attributes_1_address_2")
    end
  end
end

